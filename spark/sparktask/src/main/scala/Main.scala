import org.apache.spark.SparkContext
import org.apache.spark.sql.{Row, SparkSession}
import org.apache.spark.sql.types.{IntegerType, FloatType, StringType, StructField, StructType}

object Main {
  def main(args: Array[String]): Unit = {
    /*
    val sc = new SparkContext("local[1]", "firstWC")
    //rdd= resilient distributed dataset
    val rdd1 = sc.textFile(path="C:/Users/Ian Smith/dev/assignments.txt")
    // input line output words array
    val rdd2 = rdd1.flatMap(x => x.split(" "))
    //
    val rdd3 = rdd2.map(x=>(x.toLowerCase(),1))
    //count words
    val rdd4 = rdd3.reduceByKey((x,y)=>x+y)

    rdd4.collect().foreach(println)
    */
    val sc = new SparkContext("local[1]", "sensors")
    //rdd= resilient distributed dataset
    case class Sens(id: String, date: String, temp: Float) extends Serializable
    val filerdd = sc.textFile(path = "./data/data1.csv").filter(!_.startsWith("sensor_id,date,temp"))


    // Split each line by commas and extract temperature
    val temperatures = filerdd.map { line =>
      val Array(_, _, temp) = line.split(",")
      temp.toDouble
    }
    val sensorId = Array(0)

    val maxTemperature = temperatures.max()
    // Print the max temp
    println(s"Max temp: $maxTemperature")

    val temps = filerdd.flatMap{line=>
      val fields = line.split(",")
      val id = fields(0)
      val temp = fields(2).toDouble
      Some((id,temp))
    }

    //get sensor ids with temps greater than 50
    val gt50 = temps
      .filter{ case (_,temp)=> temp >50 }
      .map{case (id,_)=>(id,1)}
      .reduceByKey(_ + _)

   gt50.foreach{
     case (id,count)=>
       println(s"id:$id, count:$count")
   }

  }
}