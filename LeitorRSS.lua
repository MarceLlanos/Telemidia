-- Início: LeitorRSS.lua
--
-- Copyright (C) 2010 DATAPREV - Empresa de Tecnologia e Informações da Previdência Social - Brasil
--
-- Este arquivo é parte do programa TV DIGITAL SOCIAL - TVDS 
--
-- O TVDS é um software livre; você pode redistribuí­-lo e/ou modificá-lo dentro dos termos da Licença Pública Geral GNU como 
-- publicada pela Fundação do Software Livre (FSF); na versão 2 da Licença, ou (na sua opnião) qualquer versão.
--
-- Este programa é distribuído na esperança que possa ser útil, mas SEM NENHUMA GARANTIA; sem uma garantia implícita de ADEQUAÇÃO a qualquer
-- MERCADO ou APLICAÇÃO EM PARTICULAR. Veja a Licença Pública Geral GNU para maiores detalhes.
--
-- Você deve ter recebido uma cópia da Licença Pública Geral GNU, sob o título "LICENCA.txt", junto com este programa, se não, escreva para a 
-- Fundação do Software Livre(FSF) Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA.
--
--
-- ###############################################################
-- ## Leitor RSS: Captura dos pos 	ts através do codigo RSS para 
-- ## as opcoes de Twitter.
-- ###############################################################

LeitorRSS = {}
local quem = nil

local function trim (str)
   str = str:gsub ('^ +', '')
   str = str:gsub (' +', ' ')
   str = str:gsub (' +$', '')
   str = str:gsub ('\n', '')
   return str
end

-- Função responsável pela leitura e interpretação dos dados de RSS recebidos. 
function lerrss(posts, param)
	local v1, v2, v3, v4
    local titulo = nil
    local t = nil 
    local s = nil 
    local d, e
    local cont = 1
    local titulo, link, descricao, data
    local diaSemana, diaMes = 0, 0
    local str 
    local temp
	quem = param
	print('#######'..posts)
	-- Captura o conteudo do RSS
 	if (quem=="dataprev") then
    	str = webs_dataprev()
    elseif (quem=="previdencia") then
    	str = webs_previdencia()    
    end
	assert (str, 'Falhou ao carregar arquivo.')
	
	-- Decodifica HTML, substituindo codigos por caracteres
	str = Utils.decodeHTML(str)
	
	-- Captura o que há entre as tags <channel> e armazena em "t".
	-- Captura o que há entre as tags <link> e armazena em "link".
	for s in str:gmatch ('<channel>(.-)</channel>') do
		link = trim(s:match ('<link>(.-)</link>'))
		t = s
	end
	
	if (posts==1) then

		-- Atribuicoes dos valores do primeiro post
		for d in t:gmatch ('<item>(.-)</item>') do
	  		titulo = trim(d:match ('<title>(.-)</title>'))
	  		link = trim(d:match ('<link>(.-)</link>'))
	  		descricao = trim(d:match ('<description>(.-)</description>'))
	  		data = trim(d:match ('<pubDate>(.-)</pubDate>'))
	  		break
		end
	
	else 
	
	    v1 = 3	
		cont = 0
		
		-- Identificação das posições dentro da string que se encontra entre <item> e </item>
		-- para captura das informações que estão entre essas duas tags, que são os posts.
		while (cont~=posts) do
	    	cont = cont+1

			v1, v2 = string.find(t, '<item>', v1-2)
			v3, v4 = string.find(t, '</item>', v2)
			e = string.sub(t, v1-2, v4)
		
			if (cont~=posts) then
	    		v1 = v4
	    	end
		end
						
		print('##############\n'..e)
		
		-- Captura de dados.
		for d in e:gmatch ('<item>(.-)</item>') do
			titulo = trim(d:match ('<title>(.-)</title>'))
			link = trim(d:match ('<link>(.-)</link>'))
			descricao = trim(d:match ('<description>(.-)</description>'))
			data = trim(d:match ('<pubDate>(.-)</pubDate>'))
			break
		end
	end
	
	if (quem=="dataprev") then	
		descricao = string.sub(descricao, 10)
	else
		descricao = string.sub(descricao, 14)
	end
		
	diaSemana = trim(data:match ('(.-),'))
		
	-- Traduções dos dias da semana
	if (diaSemana == 'Sun') then
		diaSemana = 'Domingo'
	elseif (diaSemana == 'Mon') then
		diaSemana = 'Segunda'
	elseif (diaSemana == 'Tue') then
		diaSemana = 'Terça'
	elseif (diaSemana == 'Wed') then
		diaSemana = 'Quarta'
	elseif (diaSemana == 'Thu') then
		diaSemana = 'Quinta'
	elseif (diaSemana == 'Fri') then
		diaSemana = 'Sexta'
	elseif (diaSemana == 'Sat') then
		diaSemana = 'Sábado'
	end

	diaMes = trim(data:match (', (%d+)'))
	hora = trim(data:match ('%d%d%d%d (%d%d):%d%d:%d%d'))
	
	if (hora == '00') then
		hora = '21'
	elseif (hora == '03') then
		hora = '22'
	elseif (hora == '02') then
		hora = '23'
	else
		hora = hora - 3
		if(hora<10) then
			hora = '0'..hora
		end
	end
	
	minutos = trim(data:match ('%d%d%d%d %d%d:(%d%d):%d%d'))
	
	mes = trim(data:match ('%d%d (.-) %d%d%d%d'))
		-- Traduções dos meses
		if (mes == 'Jan') then
			mes = 'Janeiro'
		elseif (mes == 'Feb') then
			mes = 'Fevereiro'
		elseif (mes == 'Mar') then
			mes = 'Março'
		elseif (mes == 'Apr') then
			mes = 'Abril'
		elseif (mes == 'May') then
			mes = 'Maio'
		elseif (mes == 'Jun') then
			mes = 'Junho'
		elseif (mes == 'Jul') then
			mes = 'Julho'
		elseif (mes == 'Aug') then
			mes = 'Agosto'
		elseif (mes == 'Sep') then
			mes = 'Setembro'
		elseif (mes == 'Oct') then
			mes = 'Outubro'
		elseif (mes == 'Nov') then
			mes = 'Novembro'
		elseif (mes == 'Dec') then
			mes = 'Dezembro'
		end
	-- Armazena os dados capturados em uma lista.	
	POSTS = { descricao, diaSemana, diaMes, mes, hora, minutos,}

	return POSTS
end

LeitorRSS.lerrss = lerrss
-- ############################################################
-- Fim: LeitorRSS.lua
