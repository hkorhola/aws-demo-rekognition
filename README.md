# aws-rekognition-demo
Demo Ruby app for AWS image recognition service

## How to use

Create your own AWS user and set the access_key_id and secret_access_key. Also set the AWS region. Note that Rekognition doesn't work in all regions. Give an image file name as argument and that's it:

```ruby
ruby reko.rb profile.jpg
```