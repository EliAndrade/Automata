# Autômato Finito

Implementação em Lua com o objetivo de reconhecer um Autômato Finito Determinístico ou Não Determinístico.

# Teste

1) Na classe main.lua será cadastrado os estados referente ao Autômato que deseja executar.

```
local q0 = NDState:new("q0", false)
local q1 = NDState:new("q1", false)
local q2 = NDState:new("q2", true)
```

2) Logo após, na mesma classe, terá que ser feito as ligações entre os estados para formar o Autômato.

```
q0:add('0', q0)
q0:add('0', q1)
q0:add('1', q0)
q1:add('1', q2)
```

OBS: Caso o Autômato cadastrado seja Não Determinístico será necessário a transformação deste para o Determinístico através do "Reducer.reduce". Caso seja Determinístico pule para o passo 3.

```
local q0 = Reducer.reduce(q0, {"0", "1"})
```

(Sendo o "q0" o estado inicial e o "{"0", "1"}" a expressão regular para o Autômato)

3) Por último será executado o teste da palavra a escolhida no Autômato através do "Runner.runDFA".

```
Runner.runDFA(q0, "0001", "[01]")
```

(Sendo "q0" o estado inicial, "0001" a palavra a ser testada e "[01]" a expressão regular para o Autômato)
