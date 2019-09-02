class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
   include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_whitelist
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  version :thumb do
    process resize_to_fill: [100,100]
  end


 version :medium do
    process resize_to_fill: [400,400]
  end

version :project do
    process :resize_to_fill => [275, 180]
  end

  version :comment do
    process :resize_to_fill => [580, 0]
  end  

  version :projectimg do
    process resize_to_fit: [275,180]
    process :convert => :jpg   
  end

  version :featuredmd do
    process :resize_to_fill => [585, 350]
  end

  version :featuredsm do
    process :resize_to_fill => [400, 350]
  end

  version :topicbanner do
    process :resize_to_fill => [800, 350]
  end 

  version :topicmd do
    process :resize_to_fill => [450, 350]
  end 

  version :topiclg do
    process :resize_to_fill => [650, 350]
  end 

  version :userbanner do
    process :resize_to_fill => [800, 350]
  end
end
