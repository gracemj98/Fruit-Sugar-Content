import processing.serial.*;

Serial myPort; 
String val;    
int[] data; 
double[] summed;
int draw_sum=0;

double find_max(double[] input)
{
  double max = 0;
  for (int i = 0; i < input.length; i++) 
  {
    if (input[i] > max)
    {
      max = input[i];
    }            
  }
  return max;
}

void plotdata()
{
  double summed_max = (find_max(summed))/875;
  background(0); // white background
  if (draw_sum !=0)
  {
    for (int i=0; i<summed.length-1; i++)
    {
      line(i, 0, i, 875-(int)(summed[i]/summed_max));
    }
  } else
  {
    for (int i=0; i<data.length-1; i++)
    {
      line(i, 0, i, 875-data[i]);
    }
  }
  stroke(255); // black colored
}


void setup() 
{
  println(Serial.list());
  String portName = Serial.list()[1]; // index into the serial list (if only one serial device -> 0)
  myPort = new Serial(this, portName, 115200);

  summed = new double[511];

  for (int i = 0; i < 511; i++) 
  {
    summed[i] = 0;
  }

  size(292, 750); // window size
}

void draw()
{
  if ( myPort.available() > 0) 
  {  
    val = myPort.readStringUntil('\n');         // read it and store it in val
    if (val != null)
    {
      data = int(split(val, ',')); 

      for (int i = 0; i < data.length; i++) 
      {
        if (i<summed.length)
        {
          summed[i] +=  data[i];
        }
        //print(data[i]);
        //print(' ');
      }
      //println( ' ');
      plotdata();
    }
  }
}

void keyPressed() {
  if (key == 'c' ) 
  {
    for (int i = 0; i < summed.length; i++) 
    {
      summed[i] = 0;
    }
  } 
  else if (key == 't' ) 
  {
    if(draw_sum==1)
    {
      draw_sum = 0;
    }
    else
    {
      draw_sum = 1;
    }
  } 
  else 
  {
  }
}
