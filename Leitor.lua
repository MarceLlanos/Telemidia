-- In�cio: Leitor.lua
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
-- ## Leitor: 
-- ## 
-- ## 								  
-- ###############################################################

Leitor = {}

-- A string a seguir ("str") armazena a listagem dos meses e datas de pagamentos.
-- Foi declarada como string porque a norma do Middleware não prevê funções de 
-- sistema operacional para abertura de arquivos.
local str = [[#
<< MESES
	Mes1 = Dezembro/2009
	Mes2 = Janeiro/2010
 	Mes3 = Fevereiro/2010
 	Mes4 = Março/2010
 	Mes5 = Abril/2010
 	Mes6 = Maio/2010
 	Mes7 = Junho/2010
 	Mes8 = Julho/2010
 	Mes9 = Agosto/2010
 	Mes10 = Setembro/2010
 	Mes11 = Outubro/2010
 	Mes12 = Novembro/2010
 	Mes13 = Dezembro/2010
>>

# 0 = Até um salário mínimo

<<SALARIO 0

	< FINAL1
		Mes1: 22 de Dezembro
		Mes2: 25 de Janeiro
		Mes3: 22 de Fevereiro
		Mes4: 25 de Março
		Mes5: 26 de Abril
		Mes6: 25 de Maio
		Mes7: 24 de Junho
		Mes8: 26 de Julho
		Mes9: 25 de Agosto
		Mes10: 24 de Setembro
		Mes11: 25 de Outubro
		Mes12: 24 de Novembro
		Mes13: 23 de Dezembro
	>
	
	< FINAL2
		Mes1: 23 de Dezembro
		Mes2: 26 de Janeiro
		Mes3: 23 de Fevereiro 
		Mes4: 26 de Março
		Mes5: 27 de Abril
		Mes6: 26 de Maio
		Mes7: 25 de Junho
		Mes8: 27 de Julho
		Mes9: 26 de Agosto
		Mes10: 27 de Setembro
		Mes11: 26 de Outubro
		Mes12: 25 de Novembro
		Mes13: 27 de Dezembro	
	>

	< FINAL3
		Mes1: 28 de Dezembro
		Mes2: 27 de Janeiro
		Mes3: 24 de Fevereiro
		Mes4: 29 de Março
		Mes5: 28 de Abril
		Mes6: 27 de Maio
		Mes7: 28 de Junho
		Mes8: 28 de Julho
		Mes9: 27 de Agosto
		Mes10: 28 de Setembro
		Mes11: 27 de Outubro
		Mes12: 26 de Novembro
		Mes13: 28 de Dezembro
	> 

	< FINAL4
		Mes1: 29 de Dezembro
		Mes2: 28 de Janeiro
		Mes3: 25 de Fevereiro
		Mes4: 30 de Março
		Mes5: 29 de Abril
		Mes6: 28 de Maio
		Mes7: 29 de Junho
		Mes8: 29 de Julho
		Mes9: 30 de Agosto
		Mes10: 29 de Setembro
		Mes11: 28 de Outubro
		Mes12: 29 de Novembro
		Mes13: 29 de Dezembro
	>
	
	< FINAL5
		Mes1: 30 de Dezembro
		Mes2: 29 de Janeiro
		Mes3: 26 de Fevereiro
		Mes4: 31 de Março
		Mes5: 30 de Abril
		Mes6: 31 de Maio
		Mes7: 30 de Junho
		Mes8: 30 de Julho
		Mes9: 31 de Agosto
		Mes10: 30 de Setembro
		Mes11: 29 de Outubro
		Mes12: 30 de Novembro
		Mes13: 30 de Dezembro
	>
	
	< FINAL6
		Mes1: 4 de Janeiro
		Mes2: 1 de Fevereiro
		Mes3: 1 de Março
		Mes4: 1 de Abril
		Mes5: 3 de Maio
		Mes6: 1 de Junho
		Mes7: 1 de Julho
		Mes8: 2 de Agosto
		Mes9: 1 de Setembro
		Mes10: 1 de Outubro
		Mes11: 1 de Novembro
		Mes12: 1 de Dezembro
		Mes13: 3 de Janeiro
	>

	< FINAL7
		Mes1: 5 de Janeiro
		Mes2: 2 de Fevereiro
		Mes3: 2 de Março
		Mes4: 5 de Abril
		Mes5: 4 de Maio
		Mes6: 2 de Junho
		Mes7: 2 de Julho
		Mes8: 3 de Agosto
		Mes9: 2 de Setembro
		Mes10: 4 de Outubro
		Mes11: 3 de Novembro
		Mes12: 2 de Dezembro
		Mes13: 4 de Janeiro
	>

	< FINAL8
		Mes1: 6 de Janeiro
		Mes2: 3 de Fevereiro
		Mes3: 3 de Março
		Mes4: 6 de Abril
		Mes5: 5 de Maio
		Mes6: 4 de Junho
		Mes7: 5 de Julho
		Mes8: 4 de Agosto
		Mes9: 3 de Setembro
		Mes10: 5 de Outubro
		Mes11: 4 de Novembro
		Mes12: 3 de Dezembro
		Mes13: 5 de Janeiro
	>
	
	< FINAL9
		Mes1: 7 de Janeiro
		Mes2: 4 de Fevereiro
		Mes3: 4 de Março
		Mes4: 5 de Abril
		Mes5: 6 de Maio
		Mes6: 7 de Junho
		Mes7: 6 de Julho
		Mes8: 5 de Agosto
		Mes9: 6 de Setembro
		Mes10: 6 de Outubro
		Mes11: 5 de Novembro
		Mes12: 6 de Dezembro
		Mes13: 6 de Janeiro
	>

    < FINAL0
		Mes1: 8 de Janeiro
		Mes2: 5 de Fevereiro
		Mes3: 5 de Março
		Mes4: 8 de Abril
		Mes5: 7 de Maio
		Mes6: 8 de Junho
		Mes7: 7 de Julho
		Mes8: 6 de Agosto
		Mes9: 8 de Setembro
		Mes10: 7 de Outubro
		Mes11: 8 de Novembro
		Mes12: 7 de Dezembro
		Mes13: 7 de Janeiro
	>
>>
<<SALARIO 1

	< FINAL1
	< FINAL6
		Mes1: 4 de Janeiro
		Mes2: 1 de Fevereiro
		Mes3: 1 de Março
		Mes4: 1 de Abril
		Mes5: 3 de Maio
		Mes6: 1 de Junho
		Mes7: 1 de Julho
		Mes8: 2 de Agosto
		Mes9: 1 de Setembro
		Mes10:1  de Outubro
		Mes11: 1 de Novembro
		Mes12: 1 de Dezembro
		Mes13: 3 de Janeiro
	>

	< FINAL2
	< FINAL7
		Mes1: 5 de Janeiro
		Mes2: 2 de Fevereiro
		Mes3: 2 de Março
		Mes4: 5 de Abril
		Mes5: 4 de Maio
		Mes6: 2 de Junho
		Mes7: 2 de Julho
		Mes8: 3 de Agosto
		Mes9: 2 de Setembro
		Mes10: 4 de Outubro
		Mes11: 3 de Novembro
		Mes12: 2 de Dezembro
		Mes13: 4 de Janeiro
	>

	< FINAL3
	< FINAL8
		Mes1: 6 de Janeiro
		Mes2: 3 de Fevereiro
		Mes3: 3 de Março
		Mes4: 6 de Abril
		Mes5: 5 de Maio
		Mes6: 4 de Junho
		Mes7: 5 de Julho
		Mes8: 4 de Agosto
		Mes9: 3 de Setembro
		Mes10: 5 de Outubro
		Mes11: 4 de Novembro
		Mes12: 3 de Dezembro
		Mes13: 5 de Janeiro
	>
	
	< FINAL4
	< FINAL9
		Mes1: 7 de Janeiro
		Mes2: 4 de Fevereiro
		Mes3: 4 de Março
		Mes4: 7 de Abril
		Mes5: 6 de Maio
		Mes6: 7 de Junho
		Mes7: 6 de Julho
		Mes8: 5 de Agosto
		Mes9: 6 de Setembro
		Mes10: 6 de Outubro
		Mes11: 5 de Novembro
		Mes12: 6 de Dezembro
		Mes13: 6 de Janeiro
	>

    < FINAL5
    < FINAL0
		Mes1: 8 de Janeiro
		Mes2: 5 de Fevereiro
		Mes3: 5 de Março
		Mes4: 8 de Abril
		Mes5: 7 de Maio
		Mes6: 8 de Junho
		Mes7: 7 de Julho
		Mes8: 6 de Agosto
		Mes9: 8 de Setembro
		Mes10: 7 de Outubro
		Mes11: 8 de Novembro
		Mes12: 7 de Dezembro
		Mes13: 7 de Janeiro
	>

>>
]]

-- A string a seguir ("tabela") armazena a listagem das datas a partir no qual 
-- iniciou os períodos das tabelas.
-- Foi declarada como string porque a norma do Middleware não prevê funções de 
-- sistema operacional para abertura de arquivos.

tabela = [[#
<< MESES0
	Mes1 = 1º de janeiro de 2010
	Mes2 = 1º de fevereiro de 2009
	Mes3 = 1º de março de 2008
	Mes4 = 1º de janeiro de 2008
	Mes5 = 1º de abril de 2007
 	Mes6 = 1º de agosto de 2006
 	Mes7 = 1º de abril de 2006
 	Mes8 = 1º de maio de 2005
>>

<< MESES1
	Mes1 = 1º de janeiro de 2010
	Mes2 = 1º de fevereiro de 2009
	Mes3 = 1º de março de 2008
	Mes4 = 1º de abril de 2007
 	Mes5 = 1º de agosto de 2006
 	Mes6 = 1º de abril de 2006
 	Mes7 = 1º de maio de 2005
>>
	
<< TITULO

Titulo0 = Tabela de contribuição dos segurados empregado, empregado doméstico e trabalhador avulso, para pagamento de remuneração a partir de:
Titulo1 = Tabela de contribuição para segurados contribuinte individual e facultativo para pagamento de remuneração a partir de:

>>]]

-- Função que remove os comentarios da string (linhas que contem #).
local function removeComentarios(str)
   if str == nil then return nil end
   str = str:gsub ('#(.-)\n', '\n')

   -- Remove linhas em branco.
   str = str:gsub ('\n+', '\n')
   if str:find ('\n') == 1 then
      str = str:sub (2)
   end
   return str
end

local function trim (str)
   str = str:gsub ('^ +', '')
   str = str:gsub (' +', ' ')
   str = str:gsub (' +$', '')
   str = str:gsub ('\n', '')
   return str
end

-- Fun��o que determina quais s�o os meses a partir do arquivo.
function mesesCalendario()
	local MESES = {}
	local n
		for n = 1, 13 do
			for s in str:gmatch ('<< MESES(.-)>>') do
				MESES[n] = trim (s:match ('Mes'..n..' = (.-)\n'))	
				print('MES '..n..': '..MESES[n])
			end
		end
		return MESES
				
--	end
end

-- Leitor Calendario Pagamento: Função que identifica a data de pagamento a partir de dados
-- que lhe foram passados por parâmetro (número final do NIT ou benefício, mês e se até um
-- salário mínimo ou acima. 
function lerCalendario(final, mes, salario) 
    local dia = 0
    local sal = nil   -- Guarda o conteúdo de datas e final de determinado tipo de salario
    				  -- para ser usado em busca por valor específico.
	str = removeComentarios(str)

	for s in str:gmatch ('<<SALARIO '..tostring(salario)..'(.-)>>') do
	 sal = s
	end
	
	for t in sal:gmatch ('< FINAL'.. tostring(final) ..'(.-)>') do
	  dia = trim(t:match ('Mes'.. mes ..':(.-)\n'))
	end
	
	return dia
end

-- Funcao que determina quais sao os meses a partir da string tabela.
function mesesTabela()
	local MESES = {}
	local n
    
 -- ## IF pode ser utilizado se os periodos forem diferentes p/ cada tipo    
	if (segurado==0) then
		for n = 1, 8 do
			for s in tabela:gmatch ('<< MESES0(.-)>>') do
				MESES[n] = trim (s:match ('Mes'..n..' = (.-)\n'))	
				print('MES '..n..': '..MESES[n])
			end
		end
		return MESES
	else
		for n = 1, 7 do
			for s in tabela:gmatch ('<< MESES1(.-)>>') do
				MESES[n] = trim (s:match ('Mes'..n..' = (.-)\n'))	
				print('MES '..n..': '..MESES[n])
			end
		end
		return MESES	
	end
end

-- Leitor Tabela Contribuicao: Função que identifica a tabela de contribuicao desejada
-- a partir dos parâmetros mês e tipo de segurado.
function lerTabela(mes, segurado) 
    local dia = 0
    local sal = nil   -- Guarda o conteudo de datas e final de determinado tipo de salario
    				  -- para ser usado em busca por valor especifico.
    local a = nil
    
    -- Guarda em selecao o valor do periodo selecionado
	a = removeComentarios(tabela)
	if (segurado==0) then
		for r in a:gmatch ('<< MESES0(.-)>>') do
			selecao = trim (r:match ('Mes'..mes..' = (.-)\n'))
	    end
  	else
  		for r in a:gmatch ('<< MESES1(.-)>>') do
			selecao = trim (r:match ('Mes'..mes..' = (.-)\n'))
	    end
	end
  	
  	-- uarda em titulo a string que contem o titulo da tabela conforme o tipo de segurado
	a = removeComentarios(tabela)
	for p in a:gmatch ('<< TITULO(.-)>>') do
		titulo = trim (p:match ('Titulo'..tostring(segurado)..' = (.-)\n'))
    end
      	
end

Leitor.lerCalendario = lerCalendario
Leitor.mesesCalendario = mesesCalendario
Leitor.lerTabela = lerTabela
Leitor.mesesTabela = mesesTabela

-- ############################################################
-- Fim: Leitor.lua