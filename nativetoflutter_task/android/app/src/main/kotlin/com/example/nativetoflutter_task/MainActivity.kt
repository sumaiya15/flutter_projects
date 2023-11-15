package com.example.nativetoflutter_task;

import android.os.Bundle;
import android.content.Context;
import android.content.Intent;
import androidx.appcompat.app.AppCompatActivity;
import io.flutter.embedding.android.FlutterActivity;

public class MainActivity extends FlutterActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (shouldShowLoginScreen()) {
            showLoginScreen();
        }
    }

    private boolean shouldShowLoginScreen() {
        // You can implement your logic here to decide when to show the login screen
        return true;
    }

    private void showLoginScreen() {
        Intent intent = new Intent(this, LoginActivity.class);
        startActivity(intent);
    }
}

class LoginManager {
    private final Context context;

    public LoginManager(Context context) {
        this.context = context;
    }

    public void login(String username, String password) {
        // Perform the login logic here

        // If login is successful, navigate to the Flutter watchlist screen
        if (isLoginSuccessful()) {
            startFlutterActivity();
        }
    }

    private void startFlutterActivity() {
        Intent intent = new Intent(context, FlutterActivity.class);
        intent.putExtra("route", "/watchlist"); // Specify the Flutter route to the watchlist screen
        context.startActivity(intent);
    }

    private boolean isLoginSuccessful() {
        // Implement your login success logic here and return true if login is successful
        return true; // Placeholder for login success
    }
}

class LoginActivity extends AppCompatActivity {
    private final LoginManager loginManager;

    public LoginActivity() {
        loginManager = new LoginManager(this);
    }

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_login); // Set the content view with the XML layout

        // Initialize UI elements, buttons, and add event handlers here
        Button loginButton = findViewById(R.id.loginButton);

        loginButton.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                EditText usernameEditText = findViewById(R.id.usernameEditText);
                EditText passwordEditText = findViewById(R.id.passwordEditText);

                String username = usernameEditText.getText().toString();
                String password = passwordEditText.getText().toString();

                loginManager.login(username, password);
            }
        });
    }
}
