class Song < ActiveRecord::Base

  validates :title, presence: true
  validates :title, uniqueness: {
    scope: %i[release_year artist_name],
    message: 'artist cannot release same song in same year'
  }
  validates :released, inclusion: { in: [true, false] }

  with_options if: :released? do |release|
    release.validates :release_year, presence: true
    release.validates :release_year, numericality: { less_than_or_equal_to: DateTime.now.year }
  end

  validates :artist_name, presence: true

  def released?
    released
  end

end
