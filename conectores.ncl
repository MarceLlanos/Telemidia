<?xml version="1.0" encoding="ISO-8859-1"?>
<ncl id="conectores" xmlns="http://www.ncl.org.br/NCL3.0/EDTVProfile">  
<head>
	<connectorBase>
			<causalConnector id="alIniciarSetar">
				<connectorParam name="var"/>
				<simpleCondition role="onBegin" />
				<simpleAction role="set" value="$var" max="unbounded" qualifier="par"/>
			</causalConnector>

			<causalConnector id="alTerminarSetar" >
				<connectorParam name="var"/>
				<simpleCondition role="onEnd"/>
				<simpleAction role="set"   max="unbounded" qualifier="par" value="$var" />
			</causalConnector>

			<causalConnector id="alTerminarIniciar" >
				<simpleCondition role="onEnd"/>
				<simpleAction role="start" max="unbounded" qualifier="par"/>
			</causalConnector>

			<causalConnector id="alIniciarBegin" >
				<connectorParam name="var"/>
				<simpleCondition role="onBegin"/>
				<simpleAction role="start" max="unbounded" qualifier="par" />
			</causalConnector>

			<causalConnector id="alTerminarPararIniciar" >
				<connectorParam name="var"/>
				<simpleCondition role="onEnd"/>
			  <compoundAction operator="seq">
					<simpleAction role="stop"  max="unbounded" qualifier="par"/>
					<simpleAction role="start" max="unbounded" qualifier="par"/>
			  </compoundAction>
			</causalConnector>

			<causalConnector id="alTerminarParar" >
				<simpleCondition role="onEnd"/>
				<simpleAction role="stop"  max="unbounded" qualifier="par"/>
			</causalConnector>
			
			<causalConnector id="alTerminarPararIniciarSetar" >
				<connectorParam name="var"/>
				<simpleCondition role="onEnd"/>
			  <compoundAction operator="seq">
					<simpleAction role="stop"  max="unbounded" qualifier="par"/>
					<simpleAction role="start" max="unbounded" qualifier="par"/>
					<simpleAction role="set"   value="$var" max="unbounded" qualifier="par"/>
			  </compoundAction>
			</causalConnector>

		   <causalConnector id="alSeleccionarTeclaPararIniciar">
			<connectorParam name="tecla"/>
			  <simpleCondition role="onSelection" key="$tecla"/>
			  <compoundAction operator="seq">
					<simpleAction role="stop"  max="unbounded" qualifier="par"/>
					<simpleAction role="start" max="unbounded" qualifier="par"/>
				  </compoundAction>
		   </causalConnector>

		   <causalConnector id="alSeleccionarTeclaSetarPararIniciar">
			<connectorParam  name="var"/>
			<connectorParam name="tecla"/>
			<simpleCondition role="onSelection" key="$tecla"/>
			
			 <compoundAction operator="seq">
				 <simpleAction role="set"   value="$var" max="unbounded" qualifier="par"/>
				 <simpleAction role="stop"  max="unbounded" qualifier="par"/>
				 <simpleAction role="start" max="unbounded" qualifier="par"/>
			  </compoundAction>
		   </causalConnector>
		   
		   <causalConnector id="alSeleccionarSetarIniciarParar">
		   <connectorParam  name="var"/>
				<simpleCondition role="onSelection" />
			 <compoundAction operator="seq">
					 <simpleAction role="set"   value="$var" max="unbounded" qualifier="par"/>
					 <simpleAction role="start" max="unbounded" qualifier="seq"/>
					 <simpleAction role="stop"  max="unbounded" qualifier="par"/>
			 </compoundAction>
		   </causalConnector>

		   <causalConnector id="alTerminarAtribucionParar">
				<simpleCondition role="onEndAttribution"/>
				<simpleAction role="stop"  max="unbounded" qualifier="par"/>
			</causalConnector>

		   <causalConnector id="alIniciarAtribucionIniciar">
				<simpleCondition role="onBeginAttribution"/>
				<simpleAction role="start"  max="unbounded" qualifier="par"/>
			</causalConnector>

		   <causalConnector id="alTerminarAtribucionPararAbortar">
			  <connectorParam name="var"/>
				<simpleCondition role="onEndAttribution"/>
				<compoundAction operator="seq">
					<simpleAction role="stop"  max="unbounded" qualifier="par"/>
					<simpleAction role="abort"  max="unbounded" qualifier="par"/>
				</compoundAction>

			</causalConnector>

		   <causalConnector id="alTerminarAtribucionesTestearParar">
			  <connectorParam name="var"/>
			  <compoundCondition operator="and">
				  <simpleCondition role="onEndAttribution"/>
				  <assessmentStatement comparator="eq">
					<valueAssessment value="$var" />		
				  </assessmentStatement>
			  </compoundCondition>

			  <simpleAction role="stop"  max="unbounded" qualifier="par"/>
			</causalConnector>
			
		   <causalConnector id="alSeleccionarTeclaSetar">
			  <connectorParam name="var"/>
			  <connectorParam name="tecla"/>
			  <simpleCondition role="onSelection" key="$tecla"/>
				 <simpleAction role="set"   value="$var" max="unbounded" qualifier="par"/>
			</causalConnector>
			
		   <causalConnector id="alTerminarAtribucionesPararIniciar">
			  <connectorParam name="var"/>
				<simpleCondition role="onEndAttribution"/>
				  <compoundAction operator="seq">
					<simpleAction role="stop"  max="unbounded" qualifier="par"/>
					<simpleAction role="start" max="unbounded" qualifier="par"/>
				 </compoundAction>
			</causalConnector>
				
		   <causalConnector id="alSeleccionarTeclaIniciar">
			<connectorParam name="tecla"/>
			  <simpleCondition role="onSelection" key="$tecla"/>
			  <simpleAction role="start"  max="unbounded" qualifier="par"/>
		   </causalConnector>
			
		   <causalConnector id="alSeleccionTeclaParar">
			<connectorParam name="tecla"/>
			  <simpleCondition role="onSelection" key="$tecla"/>
			  <simpleAction role="stop"  max="unbounded" qualifier="par"/>
		   </causalConnector>

			<causalConnector id="alSeleccionarSetarIniciar">
				<connectorParam  name="tecla"/>
				<simpleCondition role="onSelection" key="$tecla"/>
				<compoundAction operator="seq">
					<simpleAction role="stop"  max="unbounded" qualifier="par"/>
					<simpleAction role="set"   value="$tecla" max="unbounded" qualifier="par"/>
						<simpleAction role="start" max="unbounded" qualifier="par"/>
				</compoundAction>
			</causalConnector>
				
	</connectorBase>
</head>
</ncl>