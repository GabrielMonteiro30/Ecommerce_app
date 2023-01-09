class AddAttachmentUploadToProducts < ActiveRecord::Migration[5.2]
  def self.up
    change_table :products do |t|
      t.attachment :upload
    end
  end

  def self.down
    remove_attachment :products, :upload
  end
end
