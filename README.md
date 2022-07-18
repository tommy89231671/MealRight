Unit 10: Group Milestone
===

# MealRight!
<img src="https://i.imgur.com/HyJSUu7.png" width=200>

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)

## Overview
### Description
Find reference recipes and ingredients. Moreover, can share private special recipes with other cooking lovers. Even find nearby friends to have dinner together.

### App Evaluation
- **Category:** Social Networking / Food
- **Mobile:** Based on iOS. The layout would be designed for iOS devices. Other devices may not compatible. The camera is applied for food photos.
- **Story:** Users can share their own recipes with others. And help build a healthy diet community.
- **Market:** Individuals who would like to develop healthy diets could join this app.
- **Habit:** Users can post throughout the day many times.  And they can also be inspired by others' recipes.
- **Scope:** Users can post and read recipes.  And as the population of the users increases, we can start developing community tools for users to engage with others.

## Product Spec
### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User logs in and signs up to access friend list and recipes database.
- [x] Profile pages for each user
- [x] Like posts

### 2. Screen Archetypes

* Login Screen
* Register screen - User signs up or logs in to their account
   * Upon Download/Reopening of the application, the user is prompted to log in to gain access to their profile information.
* Home Screen
   * Users can search the posts or users by titles or tags. Show their friends' recent posts.
* Post Recipe Screen
   * Allows users to be able to post their recipes.
* Recipe Details Screen
   * Allows users to be able to see the recipe details.      * like or share the posts.
* Profile Screen
   * User can see their posts
   * User can see their followers and the people they are following

### 3. Navigation

**Tab Navigation** (Tab to Screen)
* Home (read recipes)
* Recipes(post recipes)
* Profile

**Flow Navigation** (Screen to Screen)
* Register -> Log-in ->Home Screen
* Log-in -> Home Screen
* Home Screen (click recipe) -> Recipe Details Screen
* Profile Tab -> Profile Scren<<
* Recipes Tab -> Post Recipes Screen

## Wireframes
![](https://i.imgur.com/nMefvvm.gif)

## Schema

### Models

User
| Property | Type | Description |
| -------- | -------- | -------- |
| userID    | String   | Unique ID for user     |
| username | String | name of user |
| email | String | email of user |
| password | String | encrypted password |


Profile
| Property | Type | Description |
| -------- | -------- | -------- |
| user | Pointer to User | profile's user |
| Bio | String | bio for user |
| Profile_img | File | email of user |
| Friend_List | Arrays | array of pointer to users |

Post
| Property | Type | Description |
| -------- | -------- | -------- |
| RecipeID | String | UniqueID for recipe |
| Title | String | title of recipe |
| Content | String | description of recipe |
| Photo | File | food photo |
| Like | Number | number of likes |
| Share | Number | number of shares |
| CreatedAt |    DateTime |date when a post is created |
| UpdatedAt |DateTime | date when a post is last updated |


### Networking
- Login Screen
    - (Read/GET) Query logged in user object
- Register Screen
    - (Create/POST) Create a new user object
- Home Screen
    - (Read/GET) Query posts by title or tag
- Post Recipe Screen
    - (Create/POST) Create a new post
- Recipe Details Screen
    - (Read/GET) Query posts
    - (Create/POST) add like
    - (Create/POST) share post
    - (Delete) undo like
    - (Delete) undo share
- Profile Screen
    - (Read/GET) Query posts by their own username
    - (Read/GET) Query friends list

![](https://i.imgur.com/kOUXdQB.gif)
<br></br>
![](https://i.imgur.com/a2Du56E.gif)

### Final Walkthrough Video
[Video Link](https://drive.google.com/file/d/1kC0n8EOEI7BG0qZbuE29Yo_TrJNylZtB/view?usp=sharing).


