# MJAlertView
Simple automatic Dismissible Alert with minor 3D Transforms. Produces an effect similar to Saavn's dismissible Alerts

Using it, is dead simple. Just add UIView+MJAlertView Category to your project and you are good to go!

## Functions

1. Showing a simple dismissible alert
```
[UIView addMJNotifierWithText:@"Hey there!" dismissAutomatically:YES];
```
![simpleAlert](simpleAlert.gif)
![widerAlert](widerAlert.gif)


2. Showing a persistent alert
```
[UIView addMJNotifierWithText:@"This won't go. Click Dismiss to hide it!" dismissAutomatically:NO];
```
![cancelAlert](cancelAlert.gif)
![dismissAlert](dismissAlert.gif)

Animation speed, Transforming values, changing dimensions and doing any other customization is very easy. Just go to UIView+MJAlertView.m and modify it. 


Thanks!

Follow me or ask questions or just say Hi! at Twitter : <a href="https://twitter.com/mayuur" target="_blank">@mayuur</a>

## License

Usage is provided under the [MIT License](http://opensource.org/licenses/mit-license.php).  See LICENSE for the full details.
