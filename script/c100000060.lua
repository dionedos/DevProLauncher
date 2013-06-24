--スキエルＣ 
function c100000060.initial_effect(c)
	--selfdes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EVENT_ADJUST)
	e1:SetRange(LOCATION_MZONE)
	e1:SetCondition(c100000060.sdcon2)
	e1:SetOperation(c100000060.sdop)
	c:RegisterEffect(e1)
end
function c100000060.cfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x3013)
end
function c100000060.sdcon2(e,tp,eg,ep,ev,re,r,rp)
	return not Duel.IsExistingMatchingCard(c100000060.cfilter,tp,LOCATION_MZONE,LOCATION_MZONE,1,e:GetHandler())
end
function c100000060.sdop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Destroy(e:GetHandler(),REASON_EFFECT)
end