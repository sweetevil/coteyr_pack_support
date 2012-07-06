def login(user)
  post session_path, login: user.login, password: user.password
end
