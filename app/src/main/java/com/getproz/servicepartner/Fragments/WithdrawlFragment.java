package com.getproz.servicepartner.Fragments;

import android.app.ProgressDialog;
import android.content.Context;
import android.net.ConnectivityManager;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.LinearLayout;
import android.widget.Toast;

import androidx.fragment.app.Fragment;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.android.volley.NoConnectionError;
import com.android.volley.Request;
import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.TimeoutError;
import com.android.volley.VolleyError;
import com.android.volley.VolleyLog;
import com.android.volley.toolbox.Volley;
import com.google.gson.Gson;
import com.google.gson.reflect.TypeToken;
import com.getproz.servicepartner.Adapter.WithdrawalAdapter;
import com.getproz.servicepartner.Constants.CustomVolleyJsonRequest;
import com.getproz.servicepartner.Constants.Session_management;
import com.getproz.servicepartner.ModelClass.withdrawModelClass;
import com.getproz.servicepartner.R;

import org.json.JSONException;
import org.json.JSONObject;

import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.getproz.servicepartner.Constants.Config.WITHDRAWAL;


public class WithdrawlFragment extends Fragment {

    RecyclerView recyclerView;
    WithdrawalAdapter bAdapter;
    ProgressDialog progressDialog;
    private List<withdrawModelClass> list=new ArrayList<>();
    Session_management sessionManagement;
    String partnerId;
    LinearLayout noData;
    public WithdrawlFragment() {
        // Required empty public constructor
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.layout_ongoing, container, false);
        sessionManagement=new Session_management(getContext());
        partnerId=sessionManagement.userId();
        recyclerView=view.findViewById(R.id.recyclerview);
        progressDialog = new ProgressDialog(getContext());
        progressDialog.setMessage("Loading...");
        progressDialog.setCancelable(false);

        noData=view.findViewById(R.id.noData);


        RecyclerView.LayoutManager mLayoutManager = new LinearLayoutManager(getContext());
        recyclerView.setLayoutManager(mLayoutManager);
        recyclerView.setAdapter(bAdapter);

        if (!isOnline()) {
            Toast.makeText(getActivity(), "Please check your Internet Connection!", Toast.LENGTH_SHORT).show();
        } else {
            listUrl(partnerId);
        }

        return view;
    }

    private void listUrl(String partnerId) {
        progressDialog.show();
        list.clear();
        String tag_json_obj = "json_category_req";
        Map<String, String> params = new HashMap<String, String>();
        params.put("partner_id", partnerId);
        CustomVolleyJsonRequest jsonObjReq = new CustomVolleyJsonRequest(Request.Method.POST,
                WITHDRAWAL, params, new Response.Listener<JSONObject>() {
            @Override
            public void onResponse(JSONObject response) {
                Log.d("withdrawal", response.toString());
                progressDialog.dismiss();
                list.clear();
                try{
                    if (response != null && response.length() > 0) {
                        String status = response.getString("status");
                        String message = response.getString("message");
                        if (status.contains("1")) {
                            noData.setVisibility(View.GONE);
                            Gson gson = new Gson();
                            Type listType = new TypeToken<List<withdrawModelClass>>() {
                            }.getType();
                            list = gson.fromJson(response.getString("data"), listType);
                            bAdapter = new WithdrawalAdapter(getActivity(),list);
                            recyclerView.setAdapter(bAdapter);
                            bAdapter.notifyDataSetChanged();
                        }
                        else {
                            noData.setVisibility(View.VISIBLE);
                           // Toast.makeText(getContext(),message,Toast.LENGTH_SHORT).show();
                        }
                    }
                    progressDialog.dismiss();
                } catch (JSONException e) {
                    e.printStackTrace();
                }finally{
                    progressDialog.dismiss();
                }
            }
        }, new Response.ErrorListener() {

            @Override
            public void onErrorResponse(VolleyError error) {
                VolleyLog.d("TAG", "Error: " + error.getMessage());
                progressDialog.dismiss();
                if (error instanceof TimeoutError || error instanceof NoConnectionError) {
                }
            }
        });

        RequestQueue requestQueue = Volley.newRequestQueue(getContext());
        requestQueue.getCache().clear();
        requestQueue.add(jsonObjReq);
    }

    private boolean isOnline() {
        ConnectivityManager cm = (ConnectivityManager) getActivity().getSystemService(Context.CONNECTIVITY_SERVICE);
        return cm.getActiveNetworkInfo() != null && cm.getActiveNetworkInfo().isConnected();
    }

    @Override
    public void onResume() {
        super.onResume();
        listUrl(partnerId);
    }
}
