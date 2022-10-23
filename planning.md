# Plan

- Ok, a user can ask questions.. what does that mean for this app?
  - You’ll need to be able to identify yourself somehow i.e. a user rather than a visitor.
    - Something like devise?
  - Others are able to reply with answers.
    - Do they need to be signed in before they can reply?
    - In the real world: spam/abuse prevention.

Let’s make some early up-front decisions as we’re limited for time:

- I’m going to use Rails 7, ViewComponents, Stimulus and Turbo - as few unknowns as possible as time is a constraint. I can work quickly, plus it’ll be fun to do more Turbo stuff as I still haven’t used that in a production project.
- You should be able to start asking a question _before_ signing in. Who wants to go through all the hassle of signing in first, the question box should be the main UI.
  - Could we just use email as a proxy for signing in like Slack offer? Maybe a worse user experience, but the email/password combination is brutal. Could we let people
- People can vote on questions by adding a bubble (vote)…bubbles float to the top.
- Answers appear under your question without you needing to reload the page.
  - Can we re-sort the answers as people add bubbles?
- You need to be signed in to reply, but as with questions, you can start writing before you need to sign in.
  - In real-world usage, we’d want people to verify themselves but as we want this to be demo-able, maybe we skip that implementation and document it as a trade-off.

Optional If I get time:

- Each question can optionally allow anonymous answers.

### Considerations

- Accessibility
  - Keyboard Navigation
- Security
  - Logging in
- Ease of use
  - Make sure we add prompts in the UI to make it clear what’s happening.
- Performance
  - Pagination for answers and questions
  - DB indexes etc
- Fun
  - Graphics? Animations?

So the basic flow for a question asker is:

1. Type your question (can you save a draft? local storage?)
2. Click “Ask my question” at that point we ask them to enter an email and password(? - not great, but it’ll do for now)
3. Question is stored unpublished (somehow?) until they verify their email address? Protect against spam (Could we use mobile number here instead? Would be fun to try, but needing to integrate with an SMS provider is beyond scope).
4. [optional for time] Once a question is published, they get an email with the link to their question?

How will people find questions to answer, is there a basic search? Most recent questions? Most popular questions? Let’s circle back to this.

The flow for an answerer is:

1. Underneath a question, type an answer.
2. Store the answer and ask for register/sign-in (can we do this inline?)
3. Once they’ve validated their account (skipping this for demo purposes?), publish their answers.

With all of that, a quick sketch of the data we’ll need to store:

`User`

`name` - no specific need to ask for first name, surname and I don’t think adding a username gives us any benefits

`email` - mainly for verification, which we might need to skip for ability to demo

`password (etc)` - if we want to provide people a simple auth, something like devise will give us related fields

`Question`

`body` - the text of the question.

- How long can this text be?

`user_id` - reference to user

`slug` - I want people to be able to ask the question before signing in, so we need to be able to identify the questions anonymously somehow

`QuestionResponse`

`question_id` - reference to question

`user_id` - reference to user

`slug`- Like questions, we want people to be able to answer before registering/signing in so we need to be able to reference the answer anonymously before associating the user

`QuestionResponseVote`

`question_response_id` - reference to question response

`user_id` - reference to user that voted

### Considerations for initial data design

- At scale, you’d need to know how many votes each response had without wanting to calculate it on the fly each time, some of cacheing here. Will we get time to implement that?

## Approach

- Get a Rails app running.
- Build out the ask question > Register flow
  - Are we going to style this as we go along, or just get a bare-bones version working and them come back to style it? I feel like I’ll run out of time if I leave it to the end, I think we should style-as-we-go.
  - Can this be a turbo frame so the whole flow happens on one screen for the user?
- Build out the “view question” page without ability to answer/respond
- Build out a page where people can see questions that have been asked so we can find them.
  - Masonry-style layout? (I think you can do this in just CSS with CSS grid) Maybe the font size could be adjusted based on how many answers the question has?
  - Clicking on a a question take you to that question.
- Build out the “answer question” > register flow
  - Same as questions, could this happen in a frame so it’s an in-page experience?
- Build the “vote” button.
- See if we can get Turbo working with the vote counts updating live in multiple browsers.
  - Could this also update the “all questions” page? It would be cool to see the totals updating across a masonry view of all questions.
- See if we can get it to live update the ordering of the responses based on their voting.
