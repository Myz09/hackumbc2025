// Arduino 101 Button Test Code - Simplified Version
// This code tests a button connected to an Arduino 101

// Pin definitions
const int buttonPin = 7;     // Try pin 7 instead (change if needed)
const int ledPin = 13;       // Built-in LED pin for Arduino 101

// Variables
int buttonState = 0;         // Current button state
bool ledOn = false;          // LED state

void setup() {
  // Initialize serial communication
  Serial.begin(9600);
  
  // Wait for serial to initialize (important for Arduino 101)
  delay(1000);
  
  // Set pin modes
  pinMode(buttonPin, INPUT_PULLUP);  // Button pin as input with internal pullup
  pinMode(ledPin, OUTPUT);           // LED pin as output
  
  // Turn off LED initially
  digitalWrite(ledPin, LOW);
  
  // Initial messages
  Serial.println("=== Arduino 101 Button Test ===");
  Serial.println("Button connected to pin 7");
  Serial.println("Press button to toggle LED");
  Serial.println("Ready to test...");
  Serial.println("----------------------------");
}

void loop() {
  // Read button state
  buttonState = digitalRead(buttonPin);
  
  // Simple button test - when pressed, toggle LED
  if (buttonState == LOW) {  // Button pressed (LOW because of pullup resistor)
    
    // Debounce delay
    delay(200);
    
    // Toggle LED
    ledOn = !ledOn;
    digitalWrite(ledPin, ledOn);
    
    // Print status
    if (ledOn) {
      Serial.println("BUTTON PRESSED - LED ON");
    } else {
      Serial.println("BUTTON PRESSED - LED OFF");
    }
    
    // Wait for button release to prevent multiple triggers
    while (digitalRead(buttonPin) == LOW) {
      delay(10);
    }
    
    Serial.println("Button released");
  }
  
  // Small delay
  delay(50);
}

// Alternative simple version (uncomment to use instead):
/*
void loop() {
  buttonState = digitalRead(buttonPin);
  
  if (buttonState == LOW) {  // Button pressed
    Serial.println("Button is pressed");
    digitalWrite(ledPin, HIGH);  // Turn LED on
    delay(100);  // Simple debounce
  } else {
    digitalWrite(ledPin, LOW);   // Turn LED off
  }
}
*/