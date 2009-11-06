module UI
  class FileUpload

    def initialize(context, file=nil, file_field_id="file_upload", upload_url="/.files")
      @context = context
      @file_field_id = file_field_id
      @file = file
      @upload_url = upload_url
    end

    def to_s
      @context.render("ui/file_upload.html.erb", :file_field_id => @file_field_id, :file => @file, :upload_url => @upload_url).to_s
    end
  end
end