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

  #detect faces  
  resp = rekognition.detect_faces({
    image: { 
      bytes: File.read(ARGV.first) 
    },
    attributes: ["ALL"], # What attributes to return
  })
  
  resp.face_details[0].emotions.each do |emo|
    puts emo.type + " " + emo.confidence.to_i.to_s #=> String, one of "HAPPY", "SAD", "ANGRY", "CONFUSED", "DISGUSTED", "SURPRISED", "CALM", "UNKNOWN"
  end
  
  
  #get labels of image
  resp2 = rekognition.detect_labels(
          image: { bytes: File.read(ARGV.first) }
  )
    
  resp2.labels.each do |l|
    puts "#{l.name} #{l.confidence.to_i}"
  end
  
rescue Aws::Rekognition::Errors::ServiceError => e
    puts e.message
end