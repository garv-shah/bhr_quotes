# BHR Incorrect Quotes
The BHRs are a friend group I'm a part of. After I made the website for Molly's birthday (https://github.com/garv-shah/molly), I thought the same system of a random selecter could be well used in different use cases. <br>
This friend group has (and did have) an incorrect quotes document, where we would invision humorous scenarios we could be a part of and note them down as quotes. I felt that this could be quite well translated into a website as such, so I did!

## How it works:
The whole format of the website is very similar to the initial website for Molly. It's essentially a Flutter frontend paired with a Firebase backend, which is converted into an array when you access the website and then displayed randomly. The main difference here is the formatting. <br>
With Molly's website, I didn't need any formatting, but over here, I needed a single string to have bolded elements as well as new lines. In hindsight, I probably should have just used a Markdown integration, but I'm pretty sure I didn't know what Markdown was back then, or at least it didn't cross my mind. So instead, I created a very rough markup syntax for the quotes.
* `` ` ``  Made everything before it bold
* `;`  Served as a \n or \<br> and created a newline

### For example:

``` Garv:` Hello my name is Garv;Bob:` Hello Garv my name is Bob```

### Would render into the Markdown equivalent of:

```
**Garv:** Hello my name is Garv<br>
**Bob:** Hello Garv my name is Bob
```

### Which is:<br>
**Garv:** Hello my name is Garv<br>
**Bob:** Hello Garv my name is Bob

## Note:
The actual quote list in the Firestore database is far from up to date (we don't add quotes here as it's not the easiest system), so if I was to ever revisit this project, the next steps would most definetly be to switch the markup language to Markdown and have some sort of semi-automatic system to convert the quotes from the Google Doc to single raw strings

# Update - Nov 2022
So it's been about 2 years since I made this, and I rediscovered it today! I thought I'd revisit the project and add the feature above that I never got to, so I added a simple login page and a place to edit questions and add new ones directly within the website. Instead of using Markdown like I had envisioned above, the new system using Delta and a modified version of Flutter Quill to render its documents, which is quite easily stored in Firebase. It's a nice little upgrade, and I hope to use this project again!
