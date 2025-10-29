# 🎧 Noizzy — Focus starts with one click
> W4152 Engineering Software-as-a-Service — Iteration 1

---

## 👥 Team
- **Irfan Rahman** (ir2499)  
- **Colin Calvetti** (cc4918)  
- **Jialang Zheng** (jz3750)  
- **Alonzo Castro Perez** (ac5212)

---

##  Links
- **Heroku (prod):** _TBD_ — will be added after deployment (e.g. `https://noizzy-saas-w4152.herokuapp.com/`)  
- **GitHub repo:** [https://github.com/irfanrahman1/noizzy-saas-w4152](https://github.com/irfanrahman1/noizzy-saas-w4152)

---

##  What is Noizzy?

**Noizzy** is a super simple, distraction-free ambient noise web app.  
You can start focusing with **just one click**, choose from **10 curated soundscapes** (Rain, Ocean, Fan, etc.), and even use a built-in **focus timer** to stay on track.  

No ads. No playlists. No endless scrolling — just clean sound and calm focus.

---

##  Iteration 1 Scope
- Choose an ambient sound and **start/pause** instantly  
- Optional **Pomodoro-style timer**  
- **Minimal UI**, works right after page load (no login needed)

---

##  Tech Stack
- **Ruby 3.x**, **Rails 7**
- **SQLite3** (dev/test) → **PostgreSQL** (production/Heroku)
- **Puma** web server
- **RSpec** for backend testing
- **Cucumber + Capybara** for feature/system tests (`selenium_chrome_headless` driver)

---

##  How to Run, Test, and Debug Everything

Here’s everything you need — from setup to testing — all in one go 

```bash
# 1. Requirements
# Make sure you have the following installed:
# - Ruby 3.x + Bundler
# - Node.js (optional, for jsbundling-rails)
# - SQLite3 (for dev/test)
# - Google Chrome (for system tests)

# 2. Clone the repo
git clone https://github.com/irfanrahman1/noizzy-saas-w4152.git
cd noizzy-saas-w4152

# 3. Install dependencies
bundle install

# 4. Set up the database
rails db:migrate
rails db:test:prepare

# (Optional) Load seed data
rails db:seed

# 5. Run the app locally
rails server

#  Then open your browser and go to:
# http://localhost:3000
# You should see the Noizzy homepage with curated sounds.

 
#  TESTING
 

# Run RSpec tests (for models + controllers)
bundle exec rspec

# After tests finish, you can check the coverage report:
# open coverage/index.html   <-- (double-click it if on Windows)

# Run Cucumber tests (for end-to-end user behavior)
bundle exec cucumber -r features features/noizzy.feature

 
#  TROUBLESHOOTING
 

# If you get migration or database errors, reset everything:
rails db:drop db:create db:migrate db:test:prepare

# If you see “bundle not found” or “rails not recognized”:
# Make sure you're in the correct Ruby environment
# and that you're inside the Noizzy project folder.

 
#  SUMMARY COMMANDS
 

rails server                 # Run the app
bundle exec rspec            # Run backend tests
bundle exec cucumber          # Run feature tests
# open coverage/index.html   # Check code coverage
