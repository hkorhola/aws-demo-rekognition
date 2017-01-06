#for loading env variables
require 'dotenv'
Dotenv.load
require 'aws-sdk'

Aws.config.update({
  region: ENV['AWS_REGION'],
  credentials: Aws::Credentials.new(ENV['ACCESS_KEY_ID'], ENV['SECRET_ACCESS_KEY'])
})



begin
  rekognition = Aws::Rekognition::Client.new(region: Aws.config[:region], credentials: Aws.config[:credentials])
  
  if ARGV.length < 1
    abort( "Please give an image file name as argument and try again")
  else  
    img = File.read(ARGV.first)     
  end
    
  #detect faces  
  resp = rekognition.detect_faces({
    image: {
      bytes: img 
    },
    attributes: ["ALL"], # What attributes to return
  })
  
  resp.face_details[0].emotions.each do |emo|
    puts emo.type + " " + emo.confidence.to_i.to_s #=> Strings "HAPPY", "SAD", "ANGRY", "CONFUSED", "DISGUSTED", "SURPRISED", "CALM", "UNKNOWN"
  end
  
  
  #get labels of image
  resp = rekognition.detect_labels(
    image: { 
      bytes: img 
    }
  )
    
  resp.labels.each do |lb|
    puts "#{lb.name} #{lb.confidence.to_i}"
  end
  
rescue Aws::Rekognition::Errors::ServiceError => e
    puts e.message
end