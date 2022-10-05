# Parcelify

> Parcelify let you create simple yet powerful shipping rates based on address fields. Whether you'd like to create a "5$ Bike delivery" shipping rates for your neighbors, a "Free hand delivery" for your coworkers or an expensive 25$ "Plane delivery" for that remote region in your country, we've got your back.

## Table of Content

- [Documentation](#documentation)
    - [Limits](#limits)
    - [Filters](#filters)
    - [Additional cost per item](#additional-cost-per-item)
- [Examples](#examples)
- [Frequently Asked Questions](#faq)
- [Installation](#installation)
- [Additional information](#additional-information)

## Documentation

### Limits

Limits are there to limit your rate to certain conditions. Use them to make sure your rate only shows up if the order is below 25kg, or above $100, or both. When specifying limits, always use the lowest unit of your currency and weight system. Cents for US, pence for UK, etc.

### Filters

Filters allow you to limit the availability of your rate based on specific conditions, such as product SKUs or address fields. They work by combining a Field, a Verb and a Value. The **field** represents the product or address field on which you'd like to apply a condition; the **verb** represents the operation with which you'd like to compare both values; the **value** represents what you'd like to test your condition against. Let's say you'd like to create a rate that applies solely to the city of Ottawa, you could add a filter that goes as follow;

- Field: City
- Verb: Equal
- Value: Ottawa

Available verbs are;

- [Equal](#equal)
- [Start with](#start-with)
- [End with](#end-with)
- [Include](#include)
- [Exclude](#exclude)
- [Regex](#regex)

##### Equal

This one is self explainatory. This evaluates if the field equals the value. As demoed in the example above, you need to match the exact value, with accents and everything.

##### Start with

This will check if the field starts with a specific value. Let's say you'd like to offer a rate to the entire Beverly Hills region, you could check if the Zip code starts with either "902" or "903".

- **Field**: Zip code
- **Verb**: Start with
- **Value**: 90(2\|3)

##### End with

Same thing as start with, but will evaluate the end of the string instead of the beginning. It supports multiple values as well.

##### Include

The include filter checks whether or not the specified value is included anywhere in the field. It doesn't matter if the value is at the start, the end or in the middle of the string. If it's there, it's good. Let's say you'd like to offer a rate for the entire Elgin street, no matter the civic number or the appartment number, or if people add "street", or "st.", you could go as follow;

- **Field**: Address line 1
- **Verb**: Include
- **Value**: Elgin

Values such as "123 Elgin Street" would then be perfectly valid.


##### Exclude

Same thing as include but... the opposite. This is mostly useful if you'd like to exclude specific items from getting your rate. Say you'd like this rate to be valid for all carts except if it contains a product with a SKU of ABC1 or DEF2, you could do;

- **Field**: SKU
- **Verb**: Exclude
- **Value**: (ABC1)\|(DEF2)

##### Regex

A regular expression is a pattern describing a certain amount of text. That makes them ideally suited for searching, text processing and data validation. Regular expressions rely on a very strict, yet powerful syntax. While it might seems hard to grasp at first, the basics are quite easy to learn.

- ^ : Start of line
- $ : End of line
- [abc]	: A single character of: a, b, or c
- [a-z] : Any single character in the range a-z
- \d : Any digit in the range of 0-9
- \s : Any whitespace characters (space, tab, etc)
- . : Any single character
- (a\|b) : a or b
- a? : Zero or one of a
- a* : Zero or more of a
- a+ : One or more of a
- a{3} : Exactly three of a

Let's say you'd like to match all Northern Ireland postcodes, you could go as follow;

- **Field**: Zip code
- **Verb**: Regular expression
- **Value**: ^BT\d{1,2}\s

Rate would then be valid for all addresses with a zip code that starts with BT, immediately followed by one or two digits, then again followed by a whitespace. [You can find more information here](http://www.regular-expressions.info/lookaround.html) and you can [test your skills here](http://rubular.com/).

### Additional cost per item

Once you have a rate setup with your conditions, you can always decide to add additional charges for specific items. Say you sell both postcards and tables, your $2.99 standard shipping might not cut it for those big, heavy items. That's where those "extras" come handy. They rely on the same field, verb, and value pattern as described for filters, with the addition of a "price to add", which represents the value you'd like to add on the shipping rate if described condition is met. Let's say you'd like to add $50.00 shipping for each of those tables (sku: ABC1) in a cart, you could add an extra;

- **Field**: Product SKU
- **Verb**: Equal
- **Value**: ABC1
- **Price to add**: 5000

That way, in addition to our $2.99 standard shipping, an extra charge of $50.00 would be added for every table present in the cart.

## Examples

#### Free shipping on everything in US, except those few big, heavy items, then $10 worldwide shipping.

Say you want to offer free shipping on everything but on product A, B and C for which you'd like to charge $5, $10 and $15 respectively. And this needs to be restricted to US as shipping oversea costs much more. This requires a specific setup, but it's entirely doable. You'll need;

1. Create a first rate that we'll restrict to US. Let's call it "Standard shipping" for now.
2. We want this rate to be mainly free, so let's set the base price to 0 cent.
3. Let's restrict the availability of the rate to US only. Add a filter so that country code must equals US.
4. Now let's add some "extras" for those heavy items. SKU must equal A\|B\|C.
5. That's it, we now have our US rate ready. Click save.
6. Let's create another rate for worldwide shipping. Let's call it "International shipping" for now.
7. Set the price 1000. Don't forget, prices are all in cents.
8. Now we want this rate to be available everywhere but US. Add a filter to that country code excludes US.
9. Add again those extras if required.
10. All good, click save. You're done.

#### Free shipping in Canada up to 1kg, $10 afterwards. 15$ worldwide up to 1kg, $30 afterwards.

When we add limits to our rates, we end up with a matrix of availability. We'll need as many shipping rates as there are cells in our matrix. In our case, four rates.

1. Create a first rate for Canada. Let's call it "Free shipping".
2. Set the base price to 0 cent.
3. Let's add a filter for country code equals CA.
4. We also want to restrict this rate to below 1kg, so add a maximum weight of 1000 grams.
5. That's it! Click save.
6. Now create another rate, let's call it "Standard shipping".
7. Set a base price of $10.
8. Again, let's restrict that rate to Canada by adding a filter for country code equals CA.
9. We'll need the opposite limit, so add a minimum weight limit of 1000 grams.
10. All good, click save.
11. Rince and repeat for worldwide shipping, except that filters must exclude country code CA.

#### Free shipping within a fixed distance of my location

Parcelify **doesn not** support distances. This requires geolocation services which Parcelify cannot afford. The closest thing you can do to this setup is maintain a fixed list of zip codes to which you'd like to offer your special rate. It's not as accurate, but with this free app, it's the best you can do. So let's say I'm in Canada and I want to offer free shipping around my office, in Ottawa.

1. Create a free rate. Let's call it "Neighboor delivery".
2. Set the price to 0 cent. Remember; prices are always in cents.
3. Add a filter for postal code. In my case, I want to support K1N, K1P, and J8Y. Using regexes, we can write (K1(N\|P))\|(J8Y).
4. Add a filter for the country code equals CA. Otherwise the rate would be available in all countries sharing a similar postal code pattern, which I obviously don't want.

## FAQ

#### Can I use Parcelify in conjunction with another service provider?

Yes. But bear in mind that one cannot restrict the other from showing up rates. All rates defined within Parcelify will work independently from rates defined elsewhere.

#### Can I use this app if I don't have 3rd Party Shipping Carrier API?

No. And it's not because I don't want you to, this is a restriction imposed by Shopify. I'm sorry, but there's absolutely **nothing** I can do.

#### Can Parcelify blocks certain rates coming in from USPS or Fedex?

No. All rates defined within Parcelify will work independently from rates defined elsewhere, and the opposite is also true. Two shipping apps cannot interfere with one another.

#### Can I use distances to limit rates, such as a radius of 10km around my office?

No. Parcelify doesn't support distances. See examples above for portential workarounds.

#### Can I pay you to add another feature?

No. But the app is open source, so feel free to fork the repository and tweak the code as you see fit.

#### I have a list of zip codes defined somewhere else. Can I import them in Parcelify?

No. Parcelify doesn't support imports/exports. The app was created for simple use cases and any more complex scenarios could probably benefit from a bigger, stronger, but paid app. I do not have any suggestion for you.

#### Can I set a custom message when there's no rate available?

Shipping carriers do not control texts and messages within Shopify. They provide list of rates, that's it. That being said, you have full control over the text displayed in Shopify, and you can use your Theme Translation tool to find the text you'd like to change and tweak it to fit your needs.

## Installation

For regular installation, you can simply head to the [Shopify App Store](https://apps.shopify.com/parcelify) and follow regular procedures. Due to Shopify's restrictions on external shipping carriers, you'll need [a plan that support 3rd party shipping carrier](https://www.shopify.ca/pricing). If you'd like to run your own copy of this app on your own server, you can too, but you're on your own and I do not offer any help or services. It is open source with an MIT license. Feel free to clone and modify to suit your needs. It was made for Heroku but can probably run on any compatible setup. In addition to the default Heroku environement variables, you'll also need to define;

- `APPLICATION_URL`
- `SHOPIFY_CLIENT_API_KEY`
- `SHOPIFY_CLIENT_API_SECRET`

## Additional Information

### Details

- Upper and lowercase letters are considered the same
- Country codes follow the ISO 3166-1 alpha-2, 2 letters format
- State / Province codes follow the ISO 3166-2, 2 letters format

### Resources

- [Test your skills on rubular.com](http://rubular.com/)
- [View Parcelify on the Shopify App Store](https://apps.shopify.com/parcelify)
