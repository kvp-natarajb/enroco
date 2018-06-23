class TempFile < ApplicationRecord
	mount_uploader :attachment, FileUploader
end
