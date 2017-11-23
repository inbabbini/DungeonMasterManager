Paperclip::Attachment.default_options[:url] = '/attachments/:class/:attachment/:style/:hash:dotextension'
Paperclip::Attachment.default_options[:default_url] = ':class/:attachment/:class_:attachment_default.jpg'
Paperclip::Attachment.default_options[:hash_secret] = Rails.application.secrets.secret_key_base
