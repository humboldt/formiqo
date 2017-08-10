class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new # guest user (not logged in)

    if user
      can :create, Message

      if User.exists?(user.id)

        if user.subscription.end_date < Time.zone.now
          can :read, Subscription
        else
          can :manage, Mailbox
          can :manage, Message
        end

      end

    end

  end
end


# user logged in
# user logged in and has subscription
# user not logged in
