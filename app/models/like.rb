class Like < ApplicationRecord
  belongs_to :post, optional: true
  belongs_to :comment, optional: true
  belongs_to :user


  #returns users that have these likes
  def users

  end

end