require_relative '../spec_helper_full'

describe Blog do
  include SpecHelpers

  subject { Blog.new }

  before do
    setup_database
  end

  after do
    teardown_database
  end

  describe "#entries" do
    def make_entry_with_date(date)
      subject.new_post(title: 'TITLE', pubdate: date)
    end

    it "is sorted in reverse-chronological order" do
      oldest = make_entry_with_date("2011-09-09")
      newest = make_entry_with_date("2011-09-11")
      middle = make_entry_with_date("2011-09-10")

      subject.add_entry(oldest)
      subject.add_entry(newest)
      subject.add_entry(middle)

      subject.entries.must_equal([newest, middle, oldest])
    end

    it "is limited to 10 items" do
      10.times do |i|
        subject.add_entry(make_entry_with_date("2011-09-#{i+1}"))
      end
      oldest = make_entry_with_date("2011-08-30")

      subject.entries.size.must_equal(10)
      subject.entries.wont_include(oldest)
    end
  end
end
