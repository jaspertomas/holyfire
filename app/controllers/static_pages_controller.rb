class StaticPagesController < ApplicationController
  def index
    @params=params
    @cookies=cookies
  end

  def help
  end

  def admin
  end

  def error
  end

  def adminonlyerror
  end

  def encoderonlyerror
  end

  def batcheronlyerror
  end

  def initdb
  end
end
