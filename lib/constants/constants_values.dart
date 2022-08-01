String jwtToken = 'Bearer ';

void createJwt(raw) {
  jwtToken += raw;
}

String getJwt() {
  return jwtToken;
}

bool isLoggedIn = false;

void setIsLoggedIn(bool status) {
  isLoggedIn = status;
}

bool getIsLoggedIn() {
  return isLoggedIn;
}
