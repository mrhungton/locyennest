Erp::Ability.class_eval do
  def products_ability(user)
    
    # -- Product -- Start
    can :read, Erp::Products::Product
    
    can :create, Erp::Products::Product do |product|
      if Erp::Core.available?("ortho_k")
        user.get_permission(:inventory, :products, :products, :create) == 'yes'
      else
        true
      end
    end

    can :update, Erp::Products::Product do |product|
      if Erp::Core.available?("ortho_k")
        !product.archived? and user.get_permission(:inventory, :products, :products, :update) == 'yes'
      else
        !product.archived?
      end
    end

    can :archive, Erp::Products::Product do |product|
      if Erp::Core.available?("ortho_k")
        !product.archived? and user.get_permission(:inventory, :products, :products, :archive) == 'yes'
      else
        !product.archived?
      end
    end

    can :unarchive, Erp::Products::Product do |product|
      if Erp::Core.available?("ortho_k")
        product.archived? and user.get_permission(:inventory, :products, :products, :unarchive) == 'yes'
      else
        product.archived?
      end
    end
    
    if Erp::Core.available?("ortho_k")
      can :combine, Erp::Products::Product do |product|
        (!product.archived? and !product.parts.empty?) and
        user.get_permission(:inventory, :products, :products, :combine) == 'yes'
      end
  
      can :split, Erp::Products::Product do |product|
        (!product.archived? and !product.parts.empty?) and
        user.get_permission(:inventory, :products, :products, :split) == 'yes'
      end
    end
    # -- Product -- End
    
    # -- Damage Record -- Start
    # damage record /create
    can :create, Erp::Products::DamageRecord do |damage_record|
      user.get_permission(:inventory, :products, :warehouse_checks_with_damage, :create) == 'yes'
    end
    
    # damage record /update
    can :update, Erp::Products::DamageRecord do |damage_record|
      (damage_record.is_draft? or damage_record.is_pending? or damage_record.is_done? or damage_record.is_deleted?) and
      user.get_permission(:inventory, :products, :warehouse_checks_with_damage, :update) == 'yes' or
      (
        user.get_permission(:inventory, :products, :warehouse_checks_with_damage, :update) == 'in_day' and
        (damage_record.confirmed_at.nil? or Time.now < damage_record.confirmed_at.end_of_day)
      )
    end
    
    # damage record /set draft
    can :set_draft, Erp::Products::DamageRecord do |damage_record|
      false
    end
    
    # damage record /set pending
    can :set_pending, Erp::Products::DamageRecord do |damage_record|
      damage_record.is_draft?
    end
    
    # damage record /set done
    can :set_done, Erp::Products::DamageRecord do |damage_record|
      (damage_record.is_draft? or damage_record.is_pending?) and
      user.get_permission(:inventory, :products, :warehouse_checks_with_damage, :approve) == 'yes'
    end
    
    # damage record /set deleted
    can :set_deleted, Erp::Products::DamageRecord do |damage_record|
      (damage_record.is_draft? or damage_record.is_pending? or damage_record.is_done?) and
      user.get_permission(:inventory, :products, :warehouse_checks_with_damage, :delete) == 'yes'
    end
    # -- Damage Record -- End
    
    # -- Stock Check -- Start
    # stock check /create
    can :create, Erp::Products::StockCheck do |stock_check|
      user.get_permission(:inventory, :products, :warehouse_checks_with_stock, :create) == 'yes'
    end
    
    # stock check /update
    can :update, Erp::Products::StockCheck do |stock_check|
      (stock_check.is_draft? or stock_check.is_pending? or stock_check.is_done? or stock_check.is_deleted?) and
      user.get_permission(:inventory, :products, :warehouse_checks_with_stock, :update) == 'yes' or
      (
        user.get_permission(:inventory, :products, :warehouse_checks_with_stock, :update) == 'in_day' and
        (stock_check.confirmed_at.nil? or Time.now < stock_check.confirmed_at.end_of_day)
      )
    end
    
    # stock check /print/view      
    can :print, Erp::Products::StockCheck do |stock_check|
      stock_check.is_pending? or stock_check.is_done?
    end
    
    # stock check /set draft
    can :set_draft, Erp::Products::StockCheck do |stock_check|
      false
    end
    
    # stock check /set pending
    can :set_pending, Erp::Products::StockCheck do |stock_check|
      stock_check.is_draft?
    end
    
    # stock check /set done
    can :set_done, Erp::Products::StockCheck do |stock_check|
      (stock_check.is_draft? or stock_check.is_pending?) and
      user.get_permission(:inventory, :products, :warehouse_checks_with_stock, :approve) == 'yes'
    end
    
    # stock check /set deleted
    can :set_deleted, Erp::Products::StockCheck do |stock_check|
      (stock_check.is_draft? or stock_check.is_pending? or stock_check.is_done?) and
      user.get_permission(:inventory, :products, :warehouse_checks_with_stock, :delete) == 'yes'
    end
    # -- Stock Check -- End
    
    # -- State Check -- Start
    # state check /create
    can :create, Erp::Products::StateCheck do |state_check|
      user.get_permission(:inventory, :products, :warehouse_checks_with_state, :create) == 'yes'
    end
    
    # state check /update
    can :update, Erp::Products::StateCheck do |state_check|
      (state_check.is_draft? or state_check.is_pending? or state_check.is_active? or state_check.is_deleted?) and
      user.get_permission(:inventory, :products, :warehouse_checks_with_state, :update) == 'yes' or
      (
        user.get_permission(:inventory, :products, :warehouse_checks_with_state, :update) == 'in_day' and
        (state_check.confirmed_at.nil? or Time.now < state_check.confirmed_at.end_of_day)
      )
    end
    
    # state check /print/view
    can :print, Erp::Products::StateCheck do |state_check|
      state_check.is_pending? or state_check.is_active?
    end
    
    # state check /set pending
    can :set_pending, Erp::Products::StateCheck do |state_check|
      state_check.is_draft?
    end
    
    # state check /set done
    can :set_active, Erp::Products::StateCheck do |state_check|
      (state_check.is_draft? or state_check.is_pending?) and
      user.get_permission(:inventory, :products, :warehouse_checks_with_state, :approve) == 'yes'
    end
    
    # state check /set deleted
    can :set_deleted, Erp::Products::StateCheck do |state_check|
      (state_check.is_draft? or state_check.is_pending? or state_check.is_active?) and
      user.get_permission(:inventory, :products, :warehouse_checks_with_state, :delete) == 'yes'
    end
    # -- State Check -- End
    
    # Product state -- Start
    can :create, Erp::Products::State do |state|
      user.get_permission(:inventory, :products, :states, :create) == 'yes'
    end
    
    can :update, Erp::Products::State do |state|
      (state.is_draft? or state.is_active?) and
      user.get_permission(:inventory, :products, :states, :update) == 'yes'
    end
    
    can :set_draft, Erp::Products::State do |state|
      false
    end
    
    can :set_active, Erp::Products::State do |state|
      state.is_draft?
    end
    
    can :set_deleted, Erp::Products::State do |state|
      (state.is_draft? or state.is_active?) and
      user.get_permission(:inventory, :products, :states, :delete) == 'yes'
    end
    # Product state -- End
    
    # Property -- Start
    can :create, Erp::Products::Property do |property|
      if Erp::Core.available?("ortho_k")
        false
      else
        true
      end
    end
    
    can :update, Erp::Products::Property do |property|
      if Erp::Core.available?("ortho_k")
        false
      else
        true
      end
    end
    
    can :destroy, Erp::Products::Property do |property|
      if Erp::Core.available?("ortho_k")
        false
      else
        true
      end
    end
    # Property -- End
    
    # Brand -- Start
    can :create, Erp::Products::Brand do |brand|
      if Erp::Core.available?("ortho_k")
        user.get_permission(:inventory, :products, :brands, :create) == 'yes'
      else
        true
      end
    end
    
    can :update, Erp::Products::Brand do |brand|
      if Erp::Core.available?("ortho_k")
        user.get_permission(:inventory, :products, :brands, :update) == 'yes'
      else
        true
      end
    end
    
    can :destroy, Erp::Products::Brand do |brand|
      if Erp::Core.available?("ortho_k")
        false
      else
        true
      end
    end
    # Brand -- End
    
    # Category -- Start
    can :create, Erp::Products::Category do |category|
      if Erp::Core.available?("ortho_k")
        user.get_permission(:inventory, :products, :categories, :create) == 'yes'
      else
        true
      end
    end
    
    can :update, Erp::Products::Category do |category|
      if Erp::Core.available?("ortho_k")
        user.get_permission(:inventory, :products, :categories, :update) == 'yes'
      else
        true
      end
    end
    
    can :archive, Erp::Products::Category do |category|
      !category.archived and
      if Erp::Core.available?("ortho_k")
        user.get_permission(:inventory, :products, :categories, :archive) == 'yes'
      else
        true
      end
    end
    
    can :unarchive, Erp::Products::Category do |category|
      category.archived and
      if Erp::Core.available?("ortho_k")
        user.get_permission(:inventory, :products, :categories, :unarchive) == 'yes'
      else
        true
      end
    end
    # Category -- End
    
  end
end
