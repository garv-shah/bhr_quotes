# BHR Incorrect Quotes
The BHRs are a friend group I'm a part of. After I made the website for Molly's birthday (https://github.com/garv-shah/molly), I thought the same system of a random selecter could be well used in different use cases. <br>
This friend group has (and did have) an incorrect quotes document, where we would invision humorous scenarios we could be a part of and note them down as quotes. I felt that this could be quite well translated into a website as such, so I did!

## How it works:
The whole format of the website is very very similar to the initial website for Molly. It's just a Flutter frontend paired with a Firebase backend, which is converted into an array when you access the website and then displayed randomly. The only difference here is the formatting. <br>
With Molly's website, I didn't need any formatting, but over here, I needed a single string to have bolded elements as well as new lines. In hindsight, I probably should have just used a Markdown integration, but I'm pretty sure I didn't know what Markdown was back then, or at least it didn't cross my mind. So instead, I created a very rough markup syntax for the quotes.
* `` ` ``  Made everything before it bold
* `;`  Served as a \n or \<br> and created a newline
<br>

#### For example:

``` Garv:` Hello my name is Garv;Bob:` Hello Garv my name is Bob```

#### Would render into the Markdown equivalent of:

```
**Garv:** Hello my name is Garv<br>
**Bob:** Hello Garv my name is Bob
```

#### Which is:<br>
**Garv:** Hello my name is Garv<br>
**Bob:** Hello Garv my name is Bob
