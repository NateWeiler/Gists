# Bitcoin Donate

Add simple donate buttons to any website

![A screenshot of the popover bubble](https://raw.githubusercontent.com/danielquinn/bitcoin-donate/master/screenshot.png "Screenshot")

It seems like a simple thing, yet after a bunch of browsing through
[/r/bitcoin](http://www.reddit.com/r/bitcoin) and basic web searches, I couldn't
find anything like it: a quick and easy way to have a "gimme bitcoins" button on
a website.

Most sites that solicit donations simply write the address out and expect you to
copy/paste it into a desktop bitcoin client in order to make use of it -- hardly
reasonable in an age of smart phones where most of us carry are to-use cash in
our pockets and our nest-eggs in some form of hard to access storage.

What the community needs is a means of getting a QR code to show up easy for
anyone with a phone so they can donate a small amount just by pointing that
phone at the screen.

So here's how you do it:

```html
<html>
  <head>
    <link rel="stylesheet" href="/path/to/css/btcdonate.css">
  </head>
  <body>

    <h1>My Awesome Web Page</h1>

    <p>Some stuff on your page and <a href="bitcoin:A_BITCOIN_ADDRESS">a donation link</a></p>
    <p>Some more stuff on your page</p>
    <p>
      Even more stuff on your page and
      <a href="bitcoin:ANOTHER_BITCOIN_ADDRESS?amount=0.01">
        another donation link, this time with a suggested amount
      </a>.
    </p>

    <script type="text/javascript" src="/path/to/js/jquery.js"></script>
    <script type="text/javascript" src="/path/to/js/jquery.qrcode.js"></script>
    <script type="text/javascript" src="/path/to/js/btcdonate.js"></script>
    <script>
      btcdonate();
    </script>

  </body>
</html>
```

What you end up with is a standard link with an on-mouseover popup containing a
QR code.  Just point your phone, and tap "send" in whatever app you're using.
Want the popup effect on an image?  It's just like any other `<a>` tag:

```html
<a href="bitcoin:A_BITCOIN_ADDRESS"><img src="/path/to/image.png" /></a>
```

---

# Use the `href` to point to a regular URL

If you want the `onClick` event to trigger the typical behaviour of visiting a
web page rather than attempting to handle a `bitcoin:` link, you can just use
`data-btcaddress=MYADDRESS` instead:

```html
<a
  href="https://blockchain.info/address/A_BITCOIN_ADDRESS"
  data-btcaddress="A_BITCOIN_ADDRESS"
>
  Some text
</a>
```

---

# Override the Default CSS

To work, bitcoin-donate requires that you load `btcdonate.css`, but there's
nothing stopping you from adding CSS overrides after that.  If for example you
want the background colour of the bubble to be dark grey, you can do this:

```html
<link rel="stylesheet" href="/path/to/css/btcdonate.css">
<style type="text/css">
  .btcdonate-bubble {
    background: #cccccc;
  }
</style>
```

Tweak the css as you see fit.  The defaults are just a suggestion.

---

# Customise the QR code

Bitcoin-donate makes use of [jQuery-QRCode](https://github.com/lrsjng/jQuery.qrcode)
and makes some of the customising features in that library available to you.
Presently, you can fiddle with the `fill` and `radius` values to change the
colour and shape of the codes generated:

```javascript
// Change the fill to deep red and make the QR code corners sharp
btcdonate({
  fill: "#990000",
  radius: 0
});
```

---

# Working Demo & Sample Code

There's a working demo available [here](http://danielquinn.github.io/projects/bitcoin-donate/demo/),
or you can just grab this repo and open `index.html` in the `demo` directory.

There's some examples in the source of the demo if you want to see what kinds
of options you have as a developer using this code.

---

# 3rd-party libraries

Bitcoin-donate is licensed under the GPL3, but depends on two other Free
software projects [jQuery](https://github.com/jquery/jquery) (MIT license) and
[jQuery-QRCode](https://github.com/lrsjng/jQuery.qrcode) (as-is license). 

---

# Maturity

This is *very* young code and has only been tested in Firefox 30+ when 
interacting with [Andreas Schildbach's popular Bitcoin Wallet](https://play.google.com/store/apps/details?id=de.schildbach.wallet)
app available in the Google Play store.  If you have tried this out under other
circumstances please feel free to say as much in the issue queue and I'll update
the status here.

---

# Donate

Ironically, GitHub won't let you run javascript, so I can't actually *use* this
module here to solicit donations.  However all of the generated QR codes in the
demo and this README point to my address, and you can always go old-school and
copy/paste: 1BPVHqxcMAdPEtfSHLLPfpqucrDfgCGgD4

---
