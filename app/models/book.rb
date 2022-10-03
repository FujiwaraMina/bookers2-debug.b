class Book < ApplicationRecord
  belongs_to :user
  has_one_attached :profile_image
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}
  scope :created_today, -> { where(created_at: Time.zone.now.all_day) } #今日
  scope :created_yesterday, -> { where(created_at: 1.day.ago.all_day) } #前日
  scope :created_toweek, -> { where(created_at: Time.zone.now.all_week) } #今週
  scope :created_lastweek, -> {where(created_at: 1.week.ago.all_week) } #前週
  scope :created_2days, -> { where(created_at: 2.day.ago.all_day) }
  scope :created_3days, -> { where(created_at: 3.day.ago.all_day) }
  scope :created_4days, -> { where(created_at: 4.day.ago.all_day) }
  scope :created_5days, -> { where(created_at: 5.day.ago.all_day) }
  scope :created_6days, -> { where(created_at: 6.day.ago.all_day) }


  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end

  def self.looks(search,word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
end