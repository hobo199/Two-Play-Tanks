Shader "Transparent Diffuse"
{
	Properties
	{
		_TintColor ("Main Color", Color) = (1,1,1,1)
		_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
	}
	
	SubShader
	{
		Tags {"Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent"}
		Cull Off
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert alpha noforwardadd alpha:fade
		
		sampler2D _MainTex;
		fixed4 _TintColor;
		
		struct Input
		{
			float2 uv_MainTex;
			float4 color:COLOR;
		};
		
		void surf (Input IN, inout SurfaceOutput o)
		{
			fixed4 c = tex2D(_MainTex, IN.uv_MainTex);
			o.Albedo = c.rgb * _TintColor.rgb * IN.color.rgb;
			o.Alpha = c.a * _TintColor.a * IN.color.a;
		}
		ENDCG
	}
	
	Fallback "Particles/Alpha Blended"
}
