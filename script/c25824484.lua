--森羅の仙樹 レギア
function c25824484.initial_effect(c)
	--deck check
	local e1=Effect.CreateEffect(c)
	e1:SetDescription(aux.Stringid(25824484,0))
	e1:SetType(EFFECT_TYPE_IGNITION)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCountLimit(1)
	e1:SetTarget(c25824484.target)
	e1:SetOperation(c25824484.operation)
	c:RegisterEffect(e1)
	--sort decktop
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(25824484,1))
	e2:SetType(EFFECT_TYPE_SINGLE+EFFECT_TYPE_TRIGGER_F)
	e2:SetCode(EVENT_TO_GRAVE)
	e2:SetCondition(c25824484.sdcon)
	e2:SetOperation(c25824484.sdop)
	c:RegisterEffect(e2)
	if not c25824484.global_check then
		c25824484.global_check=true
		c25824484[0]=Group.CreateGroup()
		c25824484[0]:KeepAlive()
		c25824484[1]=0
		local ge1=Effect.CreateEffect(c)
		ge1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
		ge1:SetCode(EVENT_CONFIRM_DECKTOP)
		ge1:SetOperation(c25824484.checkop)
		Duel.RegisterEffect(ge1,0)
	end
end
function c25824484.checkop(e,tp,eg,ep,ev,re,r,rp)
	c25824484[0]:Clear()
	c25824484[0]:Merge(eg)
	c25824484[1]=re
end
function c25824484.target(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)>0 end
end
function c25824484.operation(e,tp,eg,ep,ev,re,r,rp)
	if Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)==0 then return end
	Duel.ConfirmDecktop(tp,1)
	local g=Duel.GetDecktopGroup(tp,1)
	local tc=g:GetFirst()
	if tc:IsRace(RACE_PLANT) then
		Duel.DisableShuffleCheck()
		Duel.SendtoGrave(tc,REASON_EFFECT)
		Duel.Draw(tp,1,REASON_EFFECT)
	else
		Duel.MoveSequence(tc,1)
	end
end
function c25824484.sdcon(e,tp,eg,ep,ev,re,r,rp)
	return re and e:GetHandler():IsPreviousLocation(LOCATION_DECK)
		and c25824484[0]:IsContains(e:GetHandler()) and c25824484[1]==re
end
function c25824484.sdop(e,tp,eg,ep,ev,re,r,rp)
	local ct=Duel.GetFieldGroupCount(tp,LOCATION_DECK,0)
	if ct==0 then return end
	local ac=1
	if ct>1 then
		Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(25824484,2))
		if ct==2 then ac=Duel.AnnounceNumber(tp,1,2)
		else ac=Duel.AnnounceNumber(tp,1,2,3) end
	end
	Duel.SortDecktop(tp,tp,ac)
end
