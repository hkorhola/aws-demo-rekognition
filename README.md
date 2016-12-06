# aws-rekognition-demo
Demo Ruby app for AWS image recognition service.

## How to use

Create your own AWS user and set the access_key_id and secret_access_key. Also set the AWS region. Note that Rekognition doesn't work in all regions. Give an image file name as argument and that's it:

```ruby
ruby reko.rb profile.jpg
```

The response lists first the emotions and their confidence levels found in the image, if a face is detected. Then it lists the labels that are recognized in the image.

```ruby
HAPPY 44
SAD 7
CONFUSED 3
People 99
Person 99
Human 99
Leisure Activities 83
Beach 66
Coast 66
Outdoors 66
Sea 66
Water 66
Man 58
Face 56
Selfie 56
Head 52
Portrait 52
Dimples 52
Smile 52
```

