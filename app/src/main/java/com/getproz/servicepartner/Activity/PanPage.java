package com.getproz.servicepartner.Activity;

import androidx.appcompat.app.AppCompatActivity;

import android.app.ProgressDialog;
import android.content.Context;
import android.net.ConnectivityManager;
import android.os.Bundle;
import android.view.View;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.LinearLayout;
import android.widget.Toast;

import com.getproz.servicepartner.Constants.Session_management;
import com.getproz.servicepartner.R;

public class PanPage extends AppCompatActivity {
    ProgressDialog progressDialog;
    Session_management sessionManagement;
    ImageView back;
    EditText RegstrdNO;
    LinearLayout SAVE,Updtae;
    String partnerID,layout;
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_pan_page);
        niiit();
    }

    private void niiit() {
        sessionManagement = new Session_management(this);
        progressDialog = new ProgressDialog(this);
        progressDialog.setMessage("Loading...");
        progressDialog.setCancelable(false);
        partnerID = sessionManagement.userId();
        layout = getIntent().getStringExtra("id");

        back = findViewById(R.id.back);
        RegstrdNO = findViewById(R.id.panNo);

        SAVE = findViewById(R.id.SAVE);
        Updtae = findViewById(R.id.Updtae);

        back.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                finish();
            }
        });
        SAVE.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (RegstrdNO.getText().toString().trim().equalsIgnoreCase("")) {
                    Toast.makeText(getApplicationContext(), "Enter PAN Card Number!", Toast.LENGTH_SHORT).show();
                } else if (!isOnline()) {
                    Toast.makeText(getApplicationContext(), "Please check your Internet Connection!", Toast.LENGTH_SHORT).show();
                } else {
                    panAddUrl();
                }
            }
        });

        if (layout != null) {
            Updtae.setVisibility(View.VISIBLE);
            SAVE.setVisibility(View.GONE);
            Updtae.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View view) {
                    if (RegstrdNO.getText().toString().trim().equalsIgnoreCase("")) {
                        Toast.makeText(getApplicationContext(), "Enter PAN Card Number", Toast.LENGTH_SHORT).show();
                    }else if (!isOnline()) {
                        Toast.makeText(getApplicationContext(), "Please check your Internet Connection!", Toast.LENGTH_SHORT).show();
                    } else {
                        updateUrl();
                    }
                }
            });
        }
    }

    private void panAddUrl() {
    }

    private void updateUrl() {
    }

    private boolean isOnline() {
        ConnectivityManager cm = (ConnectivityManager) getSystemService(Context.CONNECTIVITY_SERVICE);
        return cm.getActiveNetworkInfo() != null && cm.getActiveNetworkInfo().isConnected();
    }
}