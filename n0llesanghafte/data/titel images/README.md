# How to update Titel group photo

Replace ```titel.jpg``` with new titel group photo.

Input the KTH-ids of all Titel members in order with how they are posed in the image in titel.json as arrays in ```top kth-ids``` and ```bottom kth-ids```.

Adjust x-direction padding for top and bottom names (the distance between the names on the outside and the end of the page) using ```top-padding-x-mm```\* and ```bottom-padding-x-mm```.

Finally adjust the spacing to the top text using ```top-text-spacing-mm``` depending on which aspect ratio the image has. Tip: just make it look good.

\* The suffix -mm means that the value is in millimeters.

For example:

![Titel.jpg](/data/titel%20images/titel.jpg)

```json
{
    "top kth-ids" : ["johanhah", "toreste", "knelleus", "jplant", "olofbm"],
    "bottom kth-ids" : ["karmela", "erennel", "sbobert"],
    "top-padding-x-mm" : 0,
    "bottom-padding-x-mm" : 23,
    "top-text-spacing-mm" : -6
}
```