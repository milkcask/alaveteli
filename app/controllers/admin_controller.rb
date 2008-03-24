# app/controllers/admin_controller.rb:
# Controller for admin interface.
#
# Copyright (c) 2007 UK Citizens Online Democracy. All rights reserved.
# Email: francis@mysociety.org; WWW: http://www.mysociety.org/
#
# $Id: admin_controller.rb,v 1.6 2008-03-24 10:40:26 francis Exp $

class AdminController < ApplicationController
    layout "admin"

    def index
        # Overview counts of things
        @user_count = User.count
        @public_body_count = PublicBody.count
        @info_request_count = InfoRequest.count

        # Tasks to do
        @requires_admin_requests = InfoRequest.find(:all, :conditions => ["described_state = 'requires_admin'"])
        @blank_contacts = PublicBody.find(:all, :conditions => ["request_email = ''"])
        @two_week_old_unclassified = InfoRequest.find(:all, :conditions => [ "awaiting_description and info_requests.updated_at < ?", Time.now() - 2.weeks ])

        # Recent events
        @events_title = "Events in last week"
        date_back_to = Time.now - 1.week
        if params[:month]
            @events_title = "Events in last month"
            date_back_to = Time.now - 1.month
        end
        if params[:all]
            @events_title = "Events, all time"
            date_back_to = Time.now - 1000.years
        end
        @events = InfoRequestEvent.find(:all, :order => "created_at desc, id desc",
                :conditions => ["created_at > ? ", date_back_to])
    end
end

