-- Gênero dos Clientes

select 
	case
		when ibge.gender = 'female' then 'Mulheres'
		when ibge.gender = 'male' then 'Homens'
		end as "Genero",
		count(*) as "Total"
from sales.customers as cus
left join temp_tables.ibge_genders as ibge
	on lower(cus.first_name) = lower(ibge.first_name)
group by ibge.gender




-- Status profissional dos Clientes

select
	case 
		when professional_status = 'freelancer' then 'Freelancer' 
		when professional_status = 'retired' then 'Aposentado'
		when professional_status = 'clt' then 'Clt'
		when professional_status = 'self_employed' then 'Autônomo'
		when professional_status = 'other' then 'Outros'
		when professional_status = 'businessman' then 'Empresário'
		when professional_status = 'civil_servant' then 'Servidor Público'
		when professional_status = 'student' then 'Estudante'
		end as "Status Profissional",
		count(*) as "Total"
from sales.customers
group by professional_status


-- Faixa etária dos Clientes

Select 
	case 
		when datediff('years', birth_date,current_date) < 20 then '0-20'
		when datediff('years', birth_date,current_date) < 40 then '20-40'
		when datediff('years', birth_date,current_date) < 60 then '40-60'
		when datediff('years', birth_date,current_date) < 80 then '60-80'
		else '80+'
		end "Faixa Etária",
		count(*) as "Total"
from sales.customers
group by("Faixa Etária")
order by "Faixa Etária"




--  Idade dos veículos visitados


select 
	case
		when ((date_part('year', current_date)) - cast(model_year as integer)) < 5 then '0 - 5 Anos'
		when ((date_part('year', current_date)) - cast(model_year as integer)) < 10 then '5 - 10 Anos'
		else 'mais de 10 anos'
		end as "Faixa Veiculos",
		count(*)
from sales.funnel as fun
left join sales.products as prod
	on fun.product_id = prod.product_id
group by(1)
order by(1)


--  % dos Veículos mais visitados por marca

with veiculos_por_marca as(

select prod.brand ,count(*) as total
from sales.funnel as fun
right join sales.products as prod
	on fun.product_id = prod.product_id
group by prod.brand
order by (1)

)

select brand as "Marca", round(total / (select sum(total) from veiculos_por_marca) * 100,2) as "Porcentagem"
from veiculos_por_marca
order by 2 desc
















