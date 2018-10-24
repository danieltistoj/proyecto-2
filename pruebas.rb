# num1=" "
# for i in 1..10
# num=rand(0...9)
# num1+="#{num}"
# end
# puts num1
require 'byebug'
require 'terminal-table'

def si_desea_ingresar_otro_libro(conta)
  limpiar_pantalla
  puts 'Desea ingresar otro libro: 1) si . 2) no'
  print 'ingrese un opcion: '
  opcion = gets.to_i
      case opcion
      when 1
          return 0
      when 2
          return 1
      end
gets
end
#Ingresar el nodo venta  a la cola venta
def ingresar_detalle_en_venta(detalle_venta,venta)
  if venta[:esta_vacio]
    venta[:tope] = detalle_venta
    venta[:final] = detalle_venta
    venta[:esta_vacio] = false
    venta[:size] +=1
    venta[:max]-=1
  else
    final = venta[:final]
    final[:siguiente] = detalle_venta
    venta[:final] = detalle_venta
    venta[:size]+=1
    venta[:max]-=1
  end
end
#buscar una venta
def buscar_venta(venta,codigo)
  elemento = venta[:tope]
      conta=1
      b=0
      while conta<=venta[:size]                #VERIFICANDO QUE NO EXISTA UN AUTOR CON EL MISMO NOMBRE EN LA PILA
        if elemento[:codigo]==codigo
          b+=1
        end
        if conta!=venta[:size]
        nuevo_elemento = elemento[:siguiente]
        elemento = nuevo_elemento
        end
      conta+=1
    end
    return b
end
#Nueva venta
def nuevo_venta(venta,pila,codigo_venta)
      conta = 0
      detalle_venta = {
        size: 0,
        codigo: codigo_venta,
        tope: nil,
        subtotal: 0,
        descuento: nil,
        total_venta: nil,
        esta_vacio: true,
        final: nil,
        siguiente: nil
      }
      begin
        limpiar_pantalla
          #puts detalle_venta
          puts detalle_venta
        print 'Ingrese el ISBN del libro a vender: '
        isbn = gets.chomp
        nodo_libro = buscar_libro(pila,isbn) #nodo libro
        if nodo_libro == 'no existe el libro'
          limpiar_pantalla
          puts nodo_libro
          gets
          conta=si_desea_ingresar_otro_libro(conta)
        else #else de if nodo_libro == 'no existe el libro'
          if nodo_libro[:existencias]==0
            limpiar_pantalla
            puts 'Ya no quedan ejemplares de este libro'
            gets
            conta=si_desea_ingresar_otro_libro(conta)
          else #else nodo_libro[:existencias] == 0
            libro_venta = {
              autor: nodo_libro[:autor],
              nombre: nodo_libro[:nombre],
              precio: nodo_libro[:precio],
              ISBN: nodo_libro[:ISBN],
              siguiente: nil
            }
            if detalle_venta[:esta_vacio]
              nodo_libro[:existencias]-=1
              detalle_venta[:tope] = libro_venta
              detalle_venta[:final] = libro_venta
              detalle_venta[:esta_vacio] = false
              detalle_venta[:subtotal]+=nodo_libro[:precio]
              #cambio
              detalle_venta[:size]+=1
              conta=si_desea_ingresar_otro_libro(conta)
            else#else del if detalle_venta[:esta_vacio]
                nodo_libro[:existencias]-=1
                final = detalle_venta[:final]
                final[:siguiente] = libro_venta
                detalle_venta[:final] = libro_venta
                detalle_venta[:size]+=1
                detalle_venta[:subtotal]+=nodo_libro[:precio]
                #cambio
                conta=si_desea_ingresar_otro_libro(conta)
            end#fin de la condicion si el nodo de detalle_venta esta vacia o no
          end#fin de si existen existencias del libro.
        end#fin si existe o no el libro.
      end while  conta!=1
      return detalle_venta
end
#hacer descuento
# def descuento(detalle_venta)
#   libro_nodo = detalle_venta[:tope]
#   b=0
#   a=0
#   if   detalle_venta[:size]<=1
#     return detalle_venta
# else
#   begin
#     if libro_nodo[:ISBN] !=libro_nodo[:siguiente][:ISBN]
#       b+=1
#     end
#     if libro_nodo[:autor] != libro_nodo[:siguiente][:autor]
#       a+=1
#     end
#       libro_nodo = libro_nodo[:siguiente]
#   end while libro_nodo[:siguiente]!=nil
#     descuento1 = 0
#     descuento2 = 0
#   if  b==3
#     descuento1 = (detalle_venta[:subtotal]*0.1)
#   end
#   if b>=4
#     descuento1 = (detalle_venta[:subtotal]*0.2)
#   end
#   if a>=3
#     descuento2 = (detalle_venta[:subtotal]*0.05)
#   end
#   descuento_total = descuento1+descuento2
#   detalle_venta[:descuento] = descuento_total
#   detalle_venta[:total_venta] = detalle_venta[:subtotal]-detalle_venta[:descuento]

#   return detalle_venta
# end


#eliminar_una venta
def eliminar_una_venta(venta)
        venta[:size]-=1
        nodo = venta[:tope]
        venta[:tope] = venta[:siguiente]
        nodo = nil
end
#2.a registro venta
def registro_de_ventas(venta,pila)
  if pila[:tope]==nil
    puts 'No hay libros en el sistemas'
  else #else de pila[:tope]==nil
    if venta[:esta_vacio]
      print 'Ingrese el codigo de venta: '
      codigo_venta = gets.chomp
      detalle_venta=nuevo_venta(venta,pila,codigo_venta)
      if detalle_venta[:tope] == nil
          puts 'no se produjo una venta'
        else
          ingresar_detalle_en_venta(descuento(detalle_venta),venta)
        end

    else
      if venta[:max]>0
      print 'Ingrese el codigo de venta: '
      codigo_venta = gets.chomp
      if buscar_venta(venta,codigo_venta)>0
        puts 'El codigo que ingreso ya le pertenece a una venta en el sistema'
      else
        detalle_venta= nuevo_venta(venta,pila,codigo_venta)
        if detalle_venta[:tope] == nil
          puts 'no se produjo una venta'
        else

          ingresar_detalle_en_venta(descuento(detalle_venta),venta)
        end
      end
    else
      eliminar_una_venta(venta)
      print 'Ingrese el codigo de venta: '
      codigo_venta = gets.chomp
      if buscar_venta(venta,codigo_venta)>0
        puts 'El codigo que ingreso ya le pertenece a una venta en el sistema'
      else
        detalle_venta= nuevo_venta(venta,pila,codigo_venta)
        if detalle_venta[:tope] == nil
          puts 'no se produjo una venta'
        else

          ingresar_detalle_en_venta(descuento(detalle_venta),venta)
        end
      end
    end#..................................
    end#if esta vacio
  end#if pila tope
      gets
end#fin de registro de ventas

# Buscar una venta por nodo
def buscar_una_venta_en_cola(venta,codigo)
  elemento = venta[:tope]
  conta=1
  while conta<=venta[:size]
    if elemento[:codigo]==codigo
      conta=venta[:size]+1
      return elemento
      break
    elsif   elemento[:siguiente]==nil && elemento[:codigo]!=codigo
      return 'La venta no existe en el sistema'
      break
    else
      nuevo_elemento = elemento[:siguiente]
      elemento = nuevo_elemento
      conta+=1
    end
  end
end
#2.b buscar una venta
def mostrar_una_venta(venta)
  if venta[:tope] == nil
    puts 'No hay ventas en el sistemas'
  else
  print 'Ingrese el cogido de la venta: '
  codigo = gets.chomp
  nodo_venta = buscar_una_venta_en_cola(venta,codigo)
  if nodo_venta == 'La venta no existe en el sistema'
    puts nodo_venta
  else
    tabla = Terminal::Table.new do |t|
  t.title = 'BUSCAR UNA VENTA'
  t.headings=['codigo','subtotal','descuento','total de venta','libros vendidos']
  t.add_row([
    nodo_venta[:codigo],
    nodo_venta[:subtotal],
    nodo_venta[:descuento],
    nodo_venta[:total_venta],
    nodo_venta[:size]
  ])
end
  tabla2 = Terminal::Table.new do |a|
    a.title = 'Lista de libros vendidos'
    a.headings = ['Autor', 'Nombre', 'Precio','ISBN']

    aux = nodo_venta[:tope]
    loop do
      a.add_row([
        aux[:autor],
        aux[:nombre],
        aux[:precio],
        aux[:ISBN]
      ])
      if aux[:siguiente] == nil
        break
      end
      aux = aux[:siguiente]
    end
  end
  puts tabla
  puts tabla2
  end
end#fin primer if
gets
end
#lista de ventas**
def lista_ventas(venta)
  if venta[:tope] == nil
    puts 'No hay ventas en el sistema'
  else
    tabla2 = Terminal::Table.new do |a|
    a.title = 'Lista de libros vendidos'
    a.headings = ['Codigo', 'Subtotal', 'Descuento','Total venta','Libros vendidos']

    aux = venta[:tope]
    loop do
      a.add_row([
        aux[:codigo],
        aux[:subtotal],
        aux[:descuento],
        aux[:total_venta],
        aux[:size]
      ])
      if aux[:siguiente] == nil
        break
      end
      aux = aux[:siguiente]
    end
  end
  puts tabla2
  end
  gets
end
venta = {
  tope: nil,
  max: 20,
  size: 0,
  esta_vacio: true,
  final: nil


}

