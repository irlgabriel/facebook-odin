class Like < ApplicationRecord
  belongs_to :post, optional: true, dependent: :destroy
  belongs_to :comment, optional: true, dependent: :destroy
  belongs_to :user


  #returns users that have these likes
  def users

  end

end