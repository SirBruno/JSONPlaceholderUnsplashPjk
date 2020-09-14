# JSONPlaceholderUnsplashPjk
Salesforce project using the JSON Placeholder and Unsplash APIs. Built using Apex and Visualforce.

### What is
This project is a grid of posts fetched from the [JSON Placeholder API](https://jsonplaceholder.typicode.com). All the posts have an image cover that is fetched from the [Unsplash API](https://unsplash.com/documentation) using public authentication (i.e. only passing an access key as parameter to the request does the job, meaning there's no user specific authentication). When viewing the grid of posts, it's possible to click a button and view a specific post on a different page. It also features pagination.

### Features
- Fetching data from 2 different APIs
- Fully responsive CSS grid layout (pure CSS, no bootstrap or anything)
- A button on every post on the grid allows viewing the specific post on a different page
- Pagination with 10 posts per page
- Beautiful "dark mode" design with smooth transitions on animations

### Tech stack
- REST APIs ([JSON Placeholder API](https://jsonplaceholder.typicode.com) and [Unsplash API](https://unsplash.com/documentation))
- Built on the Salesforce CRM platform
- Most development was made using Salesforce DX for VS Code
- Apex
- Visualforce
- CSS
- Google Fonts (the font used was 'Fira Sans')
- FontAwesome (for some of the icons)
