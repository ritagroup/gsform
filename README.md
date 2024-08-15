<!-- >  **Warning**: under cunstruction  -->
</br>
</br>
</br>
</br>
<p align="center">
<img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/gsform_logo.png?raw=true" width="300" height="100">

</br>

</p>

This package helps to create forms in Flutter by removing the boilerplate needed to build a form, validate fields, react to changes and collect final user input.

Also included are common ready-made form input fields for GSForm. This gives you a convenient way of
adding common ready-made input fields instead of creating your own FormBuilderField from scratch.
<!--* Project status: working -->

<img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/header.jpg?raw=true">

See real examples:

* <https://github.com/golrangsystem/gsform/tree/main/example>

## Table of contents

<!-- Use for instance <https://github.com/ekalinin/github-markdown-toc>: -->

>   * [Installation](#installation)
>   * [Theme](#theme)
>   	* [Style](#style)
>   	* [Dark Support](#dark-support)
>   	* [Direction](#direction)
>   	* [Required Show Types](#required-show-types)
<!-- >   * [Features](#features) -->
>   * [Fields](#fields)
>   * [Attributes](#attributes)
>       * [Text](#text)
>   	* [TextPlain](#textplain)
>   	* [Number](#number)
>   	* [Spinner](#spinner)
>   	* [DatePicker](#datepicker)
>   	* [DateRangedPicker](#daterangedpicker)
>   	* [TimePicker](#timepicker)
>   	* [Mobile](#mobile)
>   	* [Email](#email)
>   	* [Password](#password)
>   	* [Price](#price)
<!-- >   	* [BankCard](#bankcard) -->
>
>
>
<!-- >     * [Content](#content) -->
<!-- >     * [Requirements](#requirements) -->
<!-- >     * [Limitations](#limitations) -->
<!-- >     * [Build](#build) -->
<!-- >     * [Deploy (how to install build product)](#deploy-how-to-install-build-product) -->
<!-- >   * [Resources (Documentation and other links)](#resources-documentation-and-other-links) -->
<!-- >   * [Contributing / Reporting issues](#contributing--reporting-issues) -->
> * [License](#license)
>   * [About Golrang System](#about-golrang-system)

## Installation

Run this command:

With Flutter:
</br>

```
flutter pub add gsform
```

This will add a line like this to your package's pubspec.yaml (and run an implicit flutter pub get):

```
dependencies:
  gsform: ^0.3.6
```

Alternatively, your editor might support flutter pub get. Check the docs for your editor to learn
more about it.

## Style

<table>
  <tr>
    <td>

```dart
GSFormStyle(
	backgroundFieldColor: COLOR,
	backgroundSectionColor: COLOR,
	sectionCardElevation: 0
	titleStyle: TextStyle,
	fieldHintStyle: TextStyle,
	fieldTextStyle: TextStyle,
	sectionRadius: 10.0,
	errorTextStyle: TextStyle,
	fieldRadius: double,
	helpTextStyle:TextStyle ,
	requireType: GSFieldRequireTypeEnum, //text, star
	sectionCardPadding: 8.0,
	requiredText: '(required)'
)

```

<td><img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/style.png?raw=true" alt="alternatetext" width="250" height="450">
	  </td>
  </tr>
 </table>

## Dark Support
As we all now Dark theme is trending and most of the popular app has the feature to turn into the dark mode, we support Dark theme in GSForm if you did'nt user custom Style in components, otherwise you should handle this yourself.

<p align="center">
<img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/darksupport.png?raw=true" alt="alternatetext"  height="450">
</br>
</p>

## Direction
Some languages of the world (Arabic, Hebrew etc.) are RTL, meaning they are read right-to-left, instead of left-to-right. GSForm Support RTL Direction !

## Required Show Types
You can set type of required show in form with GSFieldRequireTypeEnum (text Or star) 

## Fields

<table>
<tr>
<td> Row </td> <td> Field </td> <td> Sample Code </td> <td> Preview </td>
</tr>

<tr style="width:100%;">
<td> 1 </td>
<td>
<a href="#text">Text</a>
</td>
<td>

```dart
GSField.text(
	tag: 'postalCode',
	title: 'title',
	minLine: 1,
	maxLine: 1,
	weight: 12,
	required: true,
	maxLength: 100,
	errorMessage: 'error message',
	hint: 'hint message',
	helpMessage: 'help message',
	validateRegEx: regX,
	postfixWidget: widget,
	prefixWidget: widget,
)
```

</td>
<td>
<img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/text.png?raw=true" alt="alternatetext" width="150" height="270">
</td>
</tr>

<tr>
<td> 2 </td>
<td>
<a href="#textplain">Text Plain</a>
</td>
<td>

```dart
 GSField.textPlain(
	tag: 'textualAddress',
	title: 'title',
	weight: 12,
	required: true,
	errorMessage: 'error message',
	hint: 'hint message',
	helpMessage: 'help message',
	maxLength: 100,
	maxLine: 2,
	minLine: 1,
	postfixWidget: widget,
	prefixWidget: widget,
)
```

</td>
<td>
<img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/text_plain.png?raw=true" alt="alternatetext" width="150" height="270">
</td>
</tr>

<tr>
<td> 3 </td>
<td>
<a href="#number">Number</a>
</td>
<td>

```dart
   GSField.number(
	tag: '',
	title: 'title',
	weight: 12,
	maxLength: 11,
	required: true,
	errorMessage: 'Error Message',
	helpMessage: 'less than 100',
),
```

</td>
<td>
<img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/number.png?raw=true" alt="alternatetext" width="150" height="270">
</td>
</tr>

<tr id="my-row">
<td> 4 </td>
<td>
<a href="#spinner">Spinner</a>
</td>
<td>

```dart
  GSField.spinner(
	errorMessage: 'error message',
	hint: 'hint message',
	helpMessage: 'help message',
	tag: 'tag',
	required: true,
	weight: 12,
	title: 'title',
	items: [
	SpinnerDataModel(
	name: '',
	id: 1,),
	],
)
```

</td>
<td>
<img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/spinner.png?raw=true" alt="alternatetext" width="150" height="270">
</td>
</tr>

<tr>
<td> 5 </td>
<td>
<a href="#datepicker">Date Picker</a>
</td>
<td>

```dart
 GSField.datePicker(
	tag: 'tag',
	title: 'title',
	weight: 12,
	isPastAvailable: false,
	required: true,
	postfixWidget: widget,
	displayDateType: DisplayDateType.numeric,
	initialDate: Jalali.now(),
	errorMessage: 'error message',
	hint: 'hint message',
	helpMessage: 'help message',
	prefixWidget: widget,
)
```

</td>
<td>
<img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/date.png?raw=true" alt="alternatetext" width="150" height="270">
</td>
</tr>

<tr>
<td> 6 </td>
<td>
<a href="#daterangedpicker">Date Ranged Picker</a>
</td>
<td>

```dart
GSField.dateRangePicker(
	tag: 'tag',
	title: 'title',
	weight: 12,
	required: true,
	postfixWidget: widget,
	displayDateType: DisplayDateType.numeric,
	isPastAvailable: false,
	availableFrom: Jalali,
	availableTo: Jalali,
	initialDate: Jalali.now(),
	from: 'From : ',
	to: 'To : ',
	errorMessage: 'error message',
	hint: 'hint message',
	helpMessage: 'help message',
	prefixWidget: widget,
)
```

</td>
<td>
<img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/range_date.png?raw=true" alt="alternatetext" width="150" height="270">
</td>
</tr>

<tr>
<td> 7 </td>
<td>
<a href="#timepicker">Time Picker</a>
</td>
<td>

```dart
GSField.time(
	tag: 'tag',
	prefixWidget: widget,
	postfixWidget: widget,
	errorMessage: 'error message',
	hint: 'hint message',
	helpMessage: 'help message',
	required: true,
	initialTime: TimeOfDay,
	weight: 12
	)
```

</td>
<td>
<img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/time.png?raw=true" alt="alternatetext" width="150" height="270">
</td>
</tr>

<tr>
<td> 8 </td>
<td>
<a href="#mobile">Mobile</a>
</td>
<td>

```dart
GSField.mobile(
	tag: 'tag',
	errorMessage: 'error message',
	hint: 'hint message',
	helpMessage: 'help message',
	title: 'title',
	maxLength: 11,
	postfixWidget: widget,
	prefixWidget: widget,
	validateRegEx: regex,
	weight: 12,
	required: true,
)
```

</td>
<td>
<img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/mobile.png?raw=true" alt="alternatetext" width="150" height="270">
</td>
</tr>

<tr>
<td> 9 </td>
<td>
<a href="#email">Email</a>
</td>
<td>

```dart
GSField.email(
	tag: 'tag',
	errorMessage: 'error message',
	hint: 'hint message',
	helpMessage: 'help message',
	title: 'title',
	maxLength: 11,
	postfixWidget: widget,
	prefixWidget: widget,
	validateRegEx: regex,
	weight: 12,
	required: true,
)
```

</td>
<td>
<img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/email.png?raw=true" alt="alternatetext" width="150" height="270">
</td>
</tr>

<tr>
<td> 10 </td>
<td>
<a href="#password">Password</a>
</td>
<td>

```dart
GSField.password(
	tag: 'tag',
	errorMessage: 'error message',
	hint: 'hint message',
	helpMessage: 'help message',
	title: 'title',
	maxLength: 11,
	prefixWidget: widget,
	weight: 12,
	required: true,
)
```

</td>
<td>
<img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/password.png?raw=true" alt="alternatetext" width="150" height="270">
</td>
</tr>

<tr>
<td> 11 </td>
<td>
<a href="#price">Price</a>
</td>
<td>

```dart
GSField.price(
	tag: 'tag',
	errorMessage: 'error message',
	hint: 'hint message',
	helpMessage: 'help message',
	title: 'title',
	maxLength: 11,
	prefixWidget: widget,
	currencyName: "\$" ,
	weight: 12,
	required: true,
)
```

</td>
<td>
<img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/price.png?raw=true" alt="alternatetext" width="150" height="270">
</td>
</tr>

<tr>
<td> 12 </td>
<td>
Bank Card
</td>
<td>

```dart
GSField.bankCard(
	tag: 'tag',
	postfixWidget: widget,
	prefixWidget: widget,
	title: 'title',
	weight: 12,
	required: true,
	errorMessage: 'error message',
	hint: 'hint message',
	helpMessage: 'help message',
)
```

</td>
<td>
<img src="https://github.com/golrangsystem/gsform/blob/main/screenshot/card.png?raw=true" alt="alternatetext" width="150" height="270">
</td>
</tr>

</table>

## Attributes

Some features are common to all fields, which are introduced in the table below. The specific
features of each field will be explained in detail below.

<table>
  <tr>
    <td>Attribute</td>
    <td>Type</td>
    <td>Values</td>
    <td>Required</td>
    <td>Description</td>
  </tr>
  <tr>
    <td>title</td>
    <td><code> String </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>title of component</td>
  </tr>
  <tr>
    <td>tag</td>
    <td><code> String </code></td>
    <td> - </td>
    <td><code> true </code></td>
    <td>this is the id of component for receiving data</td>
  </tr>
  <tr>
    <td>errorMessage</td>
    <td><code> String </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>this is the hint that shown in component</td>
  </tr>
    <tr>
    <td>helpMessage</td>
    <td><code> String </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>this is the help message that shown in component</td>
  </tr>
   <tr>
    <td>prefixWidget</td>
    <td><code> Widget </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>this is the prefixWidget and  you can pass widget to show</td>
  </tr>
   <tr>
    <td>postfixWidget</td>
    <td><code> Widget </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>this is the postfixWidget and  you can pass widget to show</td>
  </tr>
  <tr>
    <td>required</td>
    <td><code> bool </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>this boolean show the component status for validation</td>
  </tr>
  <tr>
    <td>showTitle</td>
    <td><code> bool </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>this boolean is for make title above of component visible or inVisible</td>
  </tr>
    <tr>
    <td>status</td>
    <td><code> GSFieldStatusEnum </code></td>
    <td><code>  normal, success, error </code></td>
    <td><code> false </code></td>
    <td>this boolean is for make title above of component visible or inVisible</td>
  </tr>
     <tr>
    <td>validateRegEx</td>
    <td><code> RegExp </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>this regx for custom regx that can entered by user</td>
  </tr>
    <tr>
    <td>weight</td>
    <td><code> int </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>you can set weight for widget and max is 12 in each line</td>
  </tr>
</table>

## Text

<table>
  <tr>
    <td>Attribute</td>
    <td>Type</td>
    <td>Values</td>
    <td>Required</td>
    <td>Description</td>
  </tr>
  <tr>
    <td>maxLenght</td>
    <td><code> int </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>maximum lenght of text</td>
  </tr>
</table>

## TextPlain

<table>
  <tr>
    <td>Attribute</td>
    <td>Type</td>
    <td>Values</td>
    <td>Required</td>
    <td>Description</td>
  </tr>
  <tr>
    <td>maxLenght</td>
    <td><code> int </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>maximum lenght of text</td>
  </tr>
   <tr>
    <td>minLine</td>
    <td><code> int </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>minimum line of text</td>
  </tr>
  <tr>
    <td>maxLine</td>
    <td><code> int </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>maximum line of text</td>
  </tr>
  <tr>
    <td>showCounter</td>
    <td><code> bool </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>this boolean make counter of textField visible or invisible </td>
  </tr>
</table>

## Number

<table>
  <tr>
    <td>Attribute</td>
    <td>Type</td>
    <td>Values</td>
    <td>Required</td>
    <td>Description</td>
  </tr>
  <tr>
    <td>maxLenght</td>
    <td><code> int </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>maximum lenght of text</td>
  </tr>
</table>

## Spinner

<table>
  <tr>
    <td>Attribute</td>
    <td>Type</td>
    <td>Values</td>
    <td>Required</td>
    <td>Description</td>
  </tr>
  <tr>
    <td>items</td>
	  <td><code> List[SpinnerDataModel] </code></br></td>
    <td> - </td>
    <td><code> true </code></td>
    <td>List of data that fill spinner</td>
  </tr>
</table>

## Mobile

<table>
  <tr>
    <td>Attribute</td>
    <td>Type</td>
    <td>Values</td>
    <td>Required</td>
    <td>Description</td>
  </tr>
  <tr>
    <td>maxLenght</td>
    <td><code> int </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>maximum lenght of text</td>
  </tr>
</table>

## Email

<table>
  <tr>
    <td>Attribute</td>
    <td>Type</td>
    <td>Values</td>
    <td>Required</td>
    <td>Description</td>
  </tr>
  <tr>
    <td>maxLenght</td>
    <td><code> int </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>maximum lenght of text</td>
  </tr>
</table>

## Password

<table>
 <tr>
    <td>Attribute</td>
    <td>Type</td>
    <td>Values</td>
    <td>Required</td>
    <td>Description</td>
  </tr>
 <tr>
    <td>maxLenght</td>
    <td><code> int </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>maximum lenght of text</td>
  </tr>
</table>

## Price

<table>
 <tr>
    <td>Attribute</td>
    <td>Type</td>
    <td>Values</td>
    <td>Required</td>
    <td>Description</td>
  </tr>
 <tr>
    <td>maxLenght</td>
    <td><code> int </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>maximum lenght of text</td>
  </tr>
  <tr>
    <td>currencyName</td>
    <td><code> String </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>the Currency text for example $ </td>
  </tr>
</table>

## DatePicker

<table>
  <tr>
    <td>Attribute</td>
    <td>Type</td>
    <td>Values</td>
    <td>Required</td>
    <td>Description</td>
  </tr>
   <tr>
    <td>displayDateType</td>
    <td><code> GSCalendarType </code></td>
    <td>  jalali, gregoria </td>
    <td><code> true </code></td>
    <td>you can choose type of calendar jalali or gregorian</td>
  </tr>
  <tr>
    <td>initialDate</td>
    <td><code> GSDate </code></td>
    <td>  year,month,day </td>
    <td><code> false </code></td>
    <td>initialDate of calendar</td>
  </tr>
  <tr>
    <td>availableFrom</td>
    <td><code> GSDate </code></td>
    <td>  year,month,day </td>
    <td><code> false </code></td>
    <td>available date from</td>
  </tr>
  <tr>
    <td>availableTo</td>
    <td><code> GSDate </code></td>
    <td>  year,month,day </td>
    <td><code> false </code></td>
    <td>available date to</td>
  </tr>
  <tr>
    <td>isPastAvailable</td>
    <td><code> boolean </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>this boolean show is past available or not</td>
  </tr>
   <tr>
    <td>displayDateType</td>
    <td><code> DisplayDateType </code></td>
    <td> <code> numeric, // 1401/04/04 </code></br> <code> fullText, //  شنبه 04 تیر 1401 </code></br> <code> mediumText, // شنبه 04 تیر </code></br> <code> shortText, // 04 تیر ,1401 </code></br> </td>
    <td><code> false </code></td>
    <td>you can pass ENUM type for calendar date type</td>
  </tr>
</table>

## DateRangedPicker

<table>
  <tr>
    <td>Attribute</td>
    <td>Type</td>
    <td>Values</td>
    <td>Required</td>
    <td>Description</td>
  </tr>
  <tr>
    <td>calendarType</td>
    <td><code> GSCalendarType </code></td>
    <td>  jalali, gregoria </td>
    <td><code> true </code></td>
    <td>you can choose type of calendar jalali or gregorian</td>
  </tr>
  <tr>
    <td>displayDateType</td>
    <td><code> GSDateFormatType </code></td>
    <td> <code> numeric, // 1401/04/04 </code></br> <code> fullText, //  شنبه 04 تیر 1401 </code></br> <code> mediumText, // شنبه 04 تیر </code></br> <code> shortText, // 04 تیر ,1401 </code></br> </td>
    <td><code> false </code></td>
    <td>you can choose type of display type</td>
  </tr>
  <tr>
    <td>initialDate</td>
    <td><code> GSDate </code></td>
    <td>  year,month,day </td>
    <td><code> false </code></td>
    <td>initial date  of calendar</td>
  </tr>
  <tr>
    <td>availableFrom</td>
    <td><code> GSDate </code></td>
    <td>  year,month,day </td>
    <td><code> false </code></td>
    <td>available date from</td>
  </tr>
  <tr>
    <td>availableTo</td>
    <td><code> GSDate </code></td>
    <td>  year,month,day </td>
    <td><code> false </code></td>
    <td>available date to</td>
  </tr>
  <tr>
    <td>isPastAvailable</td>
    <td><code> boolean </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>this boolean show is past available or not</td>
  </tr>
  <tr>
    <td>from</td>
    <td><code> String </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>From text in return selected date</td>
  </tr>

  <tr>
    <td>to</td>
    <td><code> String </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>To text in return selected date</td>
  </tr>
</table>

## TimePicker

<table>
  <tr>
    <td>Attribute</td>
    <td>Type</td>
    <td>Values</td>
    <td>Required</td>
    <td>Description</td>
  </tr>
  <tr>
    <td>initialTime</td>
    <td><code> TimeOfDay </code></td>
    <td> - </td>
    <td><code> false </code></td>
    <td>initial time of calendar</td>
  </tr>
</table>


<!-- 

### Deploy (how to install build product)

Direct to MP package if any. Otherwise provide steps to deploy on Nuxeo Platform:

> Copy the built artifacts into `$NUXEO_HOME/templates/custom/bundles/` and activate the `custom` template.

## Resources (Documentation and other links)

## Contributing / Reporting issues

Link to JIRA component (or project if there is no component for that project). Samples:

* [Link to component](https://jira.nuxeo.com/issues/?jql=project%20%3D%20NXP%20AND%20component%20%3D%20Elasticsearch%20AND%20Status%20!%3D%20%22Resolved%22%20ORDER%20BY%20updated%20DESC%2C%20priority%20DESC%2C%20created%20ASC)
* [Link to project](https://jira.nuxeo.com/secure/CreateIssue!default.jspa?project=NXP)
 -->
 

## About Rita Group

Golrang System Company is an active company in the field of information and communication
technology, which aims to provide information technology solutions to help productivity and improve
the capability and profitability of Golrang Industrial Group as the arm of the senior management
since the beginning of the group's establishment. The passage of time has reached growth.

Considering the expansion of the use of information technology in the field of industry and the
trend of companies towards globalization, this company has put the provision of advanced information
and communication technology solutions on its agenda, and it tries to be an integrated task by
focusing on the field of information and communication technology. Be responsible for creating
systems, project management and technical and consulting services.

 ## Contributors
 <a href="https://github.com/golrangsystem/gsform/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=golrangsystem/gsform" />
</a>


## License

[Apache License, Version 2.0](https://www.apache.org/licenses/LICENSE-2.0.html)


