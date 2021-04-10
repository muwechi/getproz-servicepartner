package com.getproz.servicepartner.Activity;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.Intent;
import android.net.ConnectivityManager;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;

import com.android.volley.AuthFailureError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.toolbox.StringRequest;
import com.android.volley.toolbox.Volley;
import com.goodiebag.pinview.Pinview;
import com.getproz.servicepartner.R;

import org.json.JSONException;
import org.json.JSONObject;

import java.util.HashMap;
import java.util.Map;

import static com.getproz.servicepartner.Constants.Config.veriFYOtp;

public class OTPActivity extends AppCompatActivity {

    Pinview pinview;
    Button button;
    ImageView back_img;
    ProgressDialog progressDialog;
    String MobileNO;
    TextView txtMob,txtResend;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_otp);
        init();
    }
    private void init() {
        progressDialog = new ProgressDialog(this);
        progressDialog.setMessage("Please wait!");
        progressDialog.setCancelable(false);
        MobileNO=getIntent().getStringExtra("MobNo");
        txtMob = findViewById(R.id.txtMob);
        txtMob.setText("on "+MobileNO);
        back_img = findViewById(R.id.back_img);
        txtResend = findViewById(R.id.txtResend);
        back_img.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                onBackPressed();
            }
        });

        txtResend.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
            }
        });


        pinview = findViewById(R.id.pinview);
        button = findViewById(R.id.button);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                if(pinview.getValue().equalsIgnoreCase("")){
                    Toast.makeText(getApplicationContext(),"OTP required!", Toast.LENGTH_SHORT).show(); }

                else if(!isOnline()){
                    Toast.makeText(getApplicationContext(),"Please check your Internet Connection!", Toast.LENGTH_SHORT).show();
                }else {

                    otpUrl();
                }
            }
        });
    }
    private void otpUrl() {
        progressDialog.show();
        StringRequest stringRequest = new StringRequest(Request.Method.POST, veriFYOtp, new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                Log.d("OTP",response);
                progressDialog.dismiss();
                try {
                    JSONObject jsonObject = new JSONObject(response);
                    String status = jsonObject.getString("status");
                    String msg = jsonObject.getString("message");

                    if (status.equalsIgnoreCase("1")){
                        JSONObject resultObj = jsonObject.getJSONObject("data");

                        Toast.makeText(getApplicationContext(), msg+"", Toast.LENGTH_SHORT).show();
                        Intent intent= new Intent(getApplicationContext(),PasswordResetActivity.class);
                        intent.putExtra("MobNo",MobileNO);
                        startActivity(intent);
                        finish();
                    }else {
                        Toast.makeText(getApplicationContext(), msg, Toast.LENGTH_SHORT).show();
                    }
                    progressDialog.dismiss();
                } catch (JSONException e) {
                    e.printStackTrace();
                }
                progressDialog.dismiss();
            }
        }, new Response.ErrorListener() {
            @Override
            public void onErrorResponse(VolleyError error) {
            }
        }){

            @Override
            protected Map<String, String> getParams() throws AuthFailureError {
                HashMap<String, String> param = new HashMap<>();

                param.put("partner_phone",MobileNO);
                param.put("otp_value",pinview.getValue());
                return param;
            }
        };

        RequestQueue requestQueue = Volley.newRequestQueue(this);
        requestQueue.getCache().clear();
        requestQueue.add(stringRequest);

    }

    private boolean isOnline() {
        ConnectivityManager cm = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);

        return cm.getActiveNetworkInfo() != null && cm.getActiveNetworkInfo().isConnected();
    }

}
