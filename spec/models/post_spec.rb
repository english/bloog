require_relative '../spec_helper_nulldb'
require_relative '../../app/models/post'

describe Post do
  include SpecHelpers

  subject { Post.new(title: "TITLE") }
  let(:ar) { subject }

  before do
    setup_nulldb
    @ar_class = Post
  end

  after do
    teardown_nulldb
  end

  it "supports reading and writing a blog reference" do
    blog = Object.new
    subject.blog = blog
    subject.blog.must_equal blog
  end

  describe "#publish" do
    let(:blog) { stub! }

    before do
      subject.blog = blog
      stub(ar).valid? { true }
    end

    it "adds the post to the blog" do
      mock(blog).add_entry(subject)
      subject.publish
    end

    it "returns truthy on success" do
      assert(subject.publish)
    end

    describe "given an invalid post" do
      before do
        stub(ar).valid? { false }
      end

      it "wont add the post to the blog" do
        dont_allow(blog).add_entry
        subject.publish
      end

      it "returns false" do
        refute(subject.publish)
      end
    end
  end

  describe "#pubdate" do
    describe "before publishing" do
      it "is blank" do
        subject.pubdate.must_be_nil
      end
    end

    describe "after publishing" do
      let(:now) { DateTime.parse("2011-09-11T02:56") }

      before do
        clock = stub!
        stub(clock).now() { now }
        subject.blog = stub!
        subject.publish(clock)
      end

      it "is a datetime" do
        assert(subject.pubdate.is_a?(DateTime) ||
               subject.pubdate.is_a?(ActiveSupport::TimeWithZone),
               "pubdatre must be a datetime of some kind")
      end

      it "is the current time" do
        subject.pubdate.must_equal(now)
      end
    end
  end

  describe "#picure?" do
    it "is true when the post has a picture URL" do
      subject.image_url = "http://example.org/foo.png"
      assert subject.picture?
    end

    it "is false when the post has no picture URL" do
      subject.image_url = ""
      refute subject.picture?
    end
  end
end
