class Product < ApplicationRecord
  has_many :product_tags, dependent: :destroy
  has_many :tags, through: :product_tags
  has_many :subscriptions, dependent: :destroy
  has_many :subscribers, through: :subscriptions, :source => :user

  validates :title, presence: true
  validates :website_url, presence: true, url: true

  has_attached_file :picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  default_scope { includes(:subscribers, :tags) }
  scope :contains_search, -> (search) { search ? where("products.title like ? OR products.description like ?", "%#{search}%", "%#{search}%") : all }
  scope :by_user, -> (user) { where(users: { id: user.id }) }
  scope :by_tag, -> (tag) { where(tags: { description: tag }) }

  ATTRIBUTES_FOR_JSON = %i[
    id
    title
    description
    website_url
    created_at
    updated_at
  ].freeze

  METHODS_FOR_JSON = %i[
    picture_url
    subscriber_count
    tag_list
  ].freeze

  def as_json(options = {})
    options[:only] ||= ATTRIBUTES_FOR_JSON
    options[:methods] ||= METHODS_FOR_JSON
    super options
  end

  def tag_list
    self.tags.all.map(&:description).join(', ')
  end

  def tag_list=(tag_list)
    self.tags = tag_list.split(',').map do |n|
      Tag.find_or_create_by(description: n.strip)
    end
  end

  def picture_url
    picture.url
  end

  def subscriber_count
    subscribers.count
  end

  def subscribe(user)
    self.subscribers << user
  end

  def unsubscribe(user)
    self.subscribers.delete(user)
  end
end
