Hi 👋 The readme for this application is below, which I wrote after writing the bulk of the code. I wrote a separate doc for planning which I’ve [included here](https://github.com/ms-dentally-task/questionabubble/blob/main/planning.md) in case you wanted to see what I was attempting to do before I started and which bits worked/didn’t work. I’ve done my best to include these in the trade-offs listed below.

---

Welcome to Questionabubble! An application for questions and answers.

## Installation

This app was built using Ruby v3.0.0 and Rails v7.0.4. These installation instructions assume you have the correct Ruby version installed. If not, you can use a tool such as [RVM](https://rvm.io/) to install and manage Ruby versions.

- Clone the repository

```bash
git clone https://github.com/ms-dentally-task/questionabubble.git
```

- Navigate to the newly-created directory

```bash
cd questionabubble
```

- Run `bundle install` to install the gems
- Run `bin/rails db:create` to create a SQLite database
- Run `bin/rails db:migrate` to create the required tables
- Run `bin/dev` to start the app
- Navigate to `http://localhost:3000` to visit the app in your browser

### Running the tests

The tests for this app are written using RSpec. Run the tests with:

```bash
bundle exec rspec .
```

## Considerations

I’ve copied the headings I made from my initial planning notes, with some thoughts on how I got on:

- Accessibility
  - I think the app is keyboard navigable for the most part.
  - We added a skip to content link for screen reader, skipping the logo and navigation.
  - As we’re using default HTML elements for the most part, I didn’t add any specific ARIA roles.
- Security / Privacy
  - Used Devise to provide a battle-tested user auth solution rather than making my own.
  - For the “add a question/answer before signing in” feature, used a non-sequential ID to prevent people guessing the ID and viewing it.
- Ease of use
  - Hopefully wording on buttons was clear i.e. “Ask Question” and “Submit Answer” although the “Bubble Up!” features could do with some on-screen prompts to clarify that it’s a voting system.
- Performance
  - I didn’t get time to implement pagination and limited the size of queries instead. Not ideal, but I had limited time so opted for that trade-off.
  - I think there are several points that won’t scale, but tried to highlight them in git commits and listed them as next steps.
  - There are initial DB indexes in place, although I was working pretty quickly so I’d want to check that they were optimised as one of the next steps.
- Fun
  - I was able to add some graphics courtesy of [The Noun Project](https://thenounproject.com/) (I have an active license so these can be used without attribution, but check it out!).
  - I didn’t get a chance to add any animation, but it would have been fun to have some time to see if we could get the turbo streams responses working with a little CSS animation library.

## Trade-offs

- Performance trade-offs. For time, I’ve opted for implementations that may not scale.
- User experience - it’d be nice to have some more text explaining what to do, but I ran out of time.
- More tests. While there is test coverage, we don’t have system specs in here, which would give us confidence in the end-to-end working of the process. This was a trade-off for time, wanting to deliver something working against.
- HTML response fallbacks for Turbo Stream responses. I was running out of time here.
- CSS robustness - not enough time to test this robustly and had to skip any older browser support/testing for time.
- Tailwind doesn’t really make you any more efficient when you’re not using ViewComponent or React etc. I think I’d probably skip that next time, or implement some sort of component system up front (although Rails partials did the job for this scope, so Tailwind was probably a mis-match, but fun to give it another try).
- I think the mechanism I picked to allow users to create questions and answers before signing up was too complex for the time I had, could’ve used local storage or something like that. I’ve used the “store it in the DB and associate the record with the user later” approach before, but with different requirements. I didn’t get time to implement it with sign-in either, this only works with registration.
- Didn’t get time to implement the “user must confirm email address before question/answer shows” feature. Referred to this trade-off in git commits.

## Next Steps

- Fix the broken bits!
- Implement pagination to prevent limiting content
- Improve potential performance bottlenecks
- More Turbo features. It’d be great to make more things reactive in without needing a JS library, for example seeing answer totals and vote totals update dynamically across browsers/users etc. I’m really interested in how that could scale.

## Demo Video

In case it doesn't work locally, here's a demo video of the app:

https://user-images.githubusercontent.com/116505088/197403373-3b89c118-9300-4143-b1d0-e8a3ca6c9f79.mp4
