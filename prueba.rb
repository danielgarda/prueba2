
opcion = 0

txt_menu = <<BLA
Selecciona una opción
1. Calcula el promedio
2. Calcula inasistencias
3. Alumnos aprobados y reprobados
4. Salir
BLA

file = File.open('notas.csv', 'r') 
contents = file.readlines
file.close
archivo = contents.map { |linea| linea.chomp.split(',')}

def calcula_promedio(arreglo)
  salida = ''
  arreglo.map do |alum|
    nom_alumno = alum[0]
    sum_alum = (alum[1].to_i + alum[2].to_i + alum[3].to_i + alum[4].to_i + alum[5].to_i)
    prom_alum = sum_alum.to_f / (alum.length-1).to_f
    salida += "#{nom_alumno}, #{prom_alum}\n" 
  end
  File.write('promedios.csv', salida)
  return salida 
end

def calcula_inasistencias(arreglo)
  salida2 = ''
  num = 0
  arreglo.map do |alum|
    nom_alumno = alum[0]
    num += 1 if alum[1].to_s == ' A'
    num += 1 if alum[2].to_s == ' A'
    num += 1 if alum[3].to_s == ' A'
    num += 1 if alum[4].to_s == ' A'
    num += 1 if alum[5].to_s == ' A'
    salida2 += "#{nom_alumno}, #{num}\n"
    num = 0
  end
  File.write('inasistencias.csv', salida2)
end

def calcula_aprobados(arreglo, nota)
  salida3 = ''
  aprobado = 'aprobado'
  reprobado = 'reprobado'
  promedio = calcula_promedio(arreglo)
  promedio2 = promedio.split("\n").map do |alm|
    alumno = alm.split(', ')
    nom_alumno = alumno[0]
    if alumno[1].to_f >= nota
      salida3 += "#{nom_alumno}, #{aprobado}\n"
    else salida3 += "#{nom_alumno}, #{reprobado}\n"
    end
  end
  print salida3
  print "\n\n"
end
 
while opcion != 4
  print txt_menu
	opcion = gets.to_i
	case opcion 
	when 1
    calcula_promedio(archivo)
	when 2
    calcula_inasistencias(archivo)
  when 3
    print "ingresa nota de aprobación"
    print "\n"
    nota_aprob = gets.to_f
    print "\n\n"
    calcula_aprobados(archivo, nota_aprob)
	when 4
		"elegiste salir\n\n"
	else "error de opcion\n\n"
	end
end
