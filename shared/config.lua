-- COMO USAR: ESSE SCRIPT É PARA FACILITAR A VENDA DE DROGAS (OU QUALQUER ITEM) , ELE PUXA O ITEM DEFINIDO DO BAU QUE VC ESCOLHER
-- /saldofac para ver o valor das vendas
-- /sacarfac para sacar o valor das vendas
-- O ESTOQUE DE DROGAS DE CADA FAC APARECE ASSIM QUE CLICAR NO NPC

Config = {}

Config.PermAdmin = "ceo.permissao" -- PERMISSAO PARA VER O SALDO DAS FACS MESMO SEM SET

Config.SellDrugs = {
    ["Ballas"] = { -- COLOCA O NOME DO BAU EM QUE IRA RETIRAR O ITEM
        ['x'] = 97.37, ['y'] = -1989.79, ['z'] = 20.61, ['h'] = 206.93, -- COORDENADA PARA COMPRAR A DROGA
        ['x2'] = 113.61, ['y2'] = -1974.46, ['z2'] = 21.32, -- COODENADA PARA SACAR DINHEIRO
        ["hashped"] = 0x231AF63F, -- HASH DO NPC 
        ["permission"] = "ballas.permissao", -- PERMISSÃO PARA SACAR O DINHEIRO
        ["value"] = 2500, -- VALOR DE CADA DROGA
        ["item"] = "maconha", -- NOME DO ITEM VENDIDO
    },
    ["Groove"] = { -- COLOCA O NOME DO BAU EM QUE IRA RETIRAR O ITEM
        ['x'] = -162.0, ['y'] = -1698.62, ['z'] = 31.6, ['h'] = 226.78, -- COORDENADA PARA COMPRAR A DROGA
        ['x2'] = -161.25, ['y2'] = -1638.73, ['z2'] = 34.03, -- COODENADA PARA SACAR DINHEIRO
        ["hashped"] = 0x33A464E5, -- HASH DO NPC 
        ["permission"] = "families.permissao", -- PERMISSÃO PARA SACAR O DINHEIRO 
        ["value"] = 2500, -- VALOR DE CADA DROGA
        ["item"] = "cocaina", -- NOME DO ITEM VENDIDO
    },
    ["Vagos"] = { -- COLOCA O NOME DO BAU EM QUE IRA RETIRAR O ITEM
        ['x'] = 393.48, ['y'] = -2060.01, ['z'] = 21.24, ['h'] = 243.78, -- COORDENADA PARA COMPRAR A DROGA
        ['x2'] = 360.77, ['y2'] = -2042.32, ['z2'] = 22.36, -- COODENADA PARA SACAR DINHEIRO
        ["hashped"] = 0xC1C46677, -- HASH DO NPC 
        ["permission"] = "vagos.permissao", -- PERMISSÃO PARA SACAR O DINHEIRO 
        ["value"] = 2500, -- VALOR DE CADA DROGA
        ["item"] = "lsd", -- NOME DO ITEM VENDIDO
    }
}
