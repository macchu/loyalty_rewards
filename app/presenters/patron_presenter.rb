class PatronPresenter < BasePresenter
  presents :patron
  delegate :username, to: :user


end