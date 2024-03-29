class Blog
  def self.model_name
    ActiveModel::Name.new(self)
  end

  attr_writer :post_source

  def initialize(entry_fetcher = Post.public_method(:most_recent))
    @entry_fetcher = entry_fetcher
  end

  def title
    "Watching Paint Dry"
  end

  def subtitle
    "The trusted source for drying paint news and opinion"
  end

  def entries
    fetch_entries
  end

  def new_post(*args)
    post_source.call(*args).tap do |p|
      p.blog = self
    end
  end

  def add_entry(entry)
    entry.save
  end

  private

  def fetch_entries
    @entry_fetcher.()
  end

  def post_source
    @post_source ||= Post.public_method(:new)
  end
end
