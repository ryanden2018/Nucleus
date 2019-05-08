class GroupPost < ApplicationRecord
  belongs_to :group
  belongs_to :post

  def self.delete_all_for_post(post)
    self.where(post_id: post.id).each { |gp| gp.destroy }
  end

end
