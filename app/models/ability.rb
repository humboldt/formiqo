class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user
      if user.subscription.try(:expired?)
        can :read, Subscription
        can :read, Plan
        can :index, Mailbox
      else
        can [:read, :create, :update, :destroy], Mailbox, user_id: user.id
        can [:index, :destroy], Message do |m|
          m.mailbox.user_id == user.id
        end
        can :create, Message
        can :read, Subscription
        can :read, Plan
      end

    else
      can :create, Message
    end
  end
end
