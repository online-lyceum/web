<template>
    <div id="App">
        <select-class @select="selectingClass" />
        <lesson-list :class_id="class_id" />
    </div>
</template>

<script>
import SelectClass from "@/components/SelectClass"
import LessonList from "@/components/LessonList"

export default {
  name: 'App',
  data() {
    return {
        class_id: undefined 
    }
  },
  components: {
    SelectClass,
    LessonList
  },
  methods: {
    selectingClass(class_id) {
        this.class_id = class_id
    }
  }
}
</script>

<style>
#App {
    padding: 20px;
}
</style>
